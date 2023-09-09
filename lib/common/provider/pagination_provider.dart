import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_foodies/common/model/cursor_pagination_model.dart';
import 'package:winter_foodies/common/model/model_with_id.dart';
import 'package:winter_foodies/common/model/pagination_params.dart';
import 'package:winter_foodies/common/repository/base_pagination_repository.dart';

class _PaginationInfo {
  final int fetchCount;
  final bool fetchMore;
  final bool forceRefetch;
  final String? researchType;

  _PaginationInfo({
    this.fetchCount = 10,
    this.fetchMore = false,
    this.forceRefetch = false,
    this.researchType,
  });
}

//pagination 일반화 시작
//여기 extends == implements
//model type, repository type
class PaginationProvider<T extends IModelWithId,
U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository; //U타입 repository
  //throttle 시작
  final paginationThrottle = Throttle(
    Duration(seconds: 1),
    initialValue: _PaginationInfo(), //맨처음 실행
    checkEquality: false,
  );

  PaginationProvider({
    required this.repository,
    bool autoFetch = true, // 새로운 매개변수 추가
  }) : super(CursorPaginationLoading()) {
    if(autoFetch) paginate();
    paginationThrottle.values.listen(
          (state) {
        _throttledPagination(state);
      },
    );
  }

  Future<void> paginate({
    String? researchType,
    int fetchCount = 10,
    //추가로 데이터 더 가져오기
    //true - 추가로 데이터 더 가져옴
    //false - 새로고침(현재 상태 덮어씌움)
    bool fetchMore = false,
    //강제로 다시 로딩하기
    //true - CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    researchType = researchType ?? paginationThrottle.value.researchType;
    paginationThrottle.setValue(_PaginationInfo(
      fetchMore: fetchMore,
      fetchCount: fetchCount,
      forceRefetch: forceRefetch,
      researchType: researchType,
    )); //1개 밖에 못넣기때메 fetch관련 3개를 클래스로 묶어전달
  }

  // researchType을 받지 않는 새로운 버전의 paginate 함수를 추가합니다.
  Future<void> paginateWithoutType({
    int fetchCount = 10,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    // 기존의 paginate 함수를 호출하되 researchType을 전달하지 않습니다.
    return paginate(
      fetchCount: fetchCount,
      fetchMore: fetchMore,
      forceRefetch: forceRefetch,
    );
  }


  _throttledPagination(_PaginationInfo info) async {
    final fetchCount = info.fetchCount;
    final fetchMore = info.fetchMore;
    final forceRefetch = info.forceRefetch;
    var researchType = info.researchType; // 여기서 researchType 정보를 가져옵니다.

    // 결정할 path 값
    String path = '/';
    if (researchType == 'me') {
      path = '/me';
      researchType = null;  // /me 엔드포인트에는 researchType이 필요하지 않으므로 null로 설정
    }



    try {
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;
        print(pState.meta.hasMore);
        if (!pState.meta.hasMore) {
          print(pState.meta.hasMore);
          return; //1) 기존 상태에서 이미 다음 데이터가 없다고 되어있다면? -> 리턴
        }
      }

      final isLoading = state is CursorPaginationLoading; //완전 첫 로딩
      final isRefetching = state is CursorPaginationRefetching; //새로고침 로딩
      final isFetchingMore = state is CursorPaginationFetchingMore; //밑에 대기 로딩

      //  2) CursorPaginationLoading - 데이터가 로딩중인 상태(현재 캐시 X)
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      //PaginationParams 생성(copywith으로 after나 count변경가능)
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount, //안넣어줘도 되긴함 이미 default 20
      );

      // fetchMore
      // 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination<T>;
        //요기서 걸리면
        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );
        //paginationParams변경 필요
        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      else {
        // 만약 데이터가 있는 상황?
        // 기존 데이터 보존하고 Fetch (API 요청) 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;
          state = CursorPaginationRefetching<T>(
            meta: pState.meta,
            data: pState.data,
          );
        }
        // 나머지 상황
        else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        path: path,
        researchType: researchType,
        paginationParams: paginationParams, //쿼리로 자동 반환되는 paginationParams
      );

      print(researchType);

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

        //다음 20개 데이터 받아왓기때문에 기존 데이터와 합쳐줄 작업!!
        state = resp.copyWith(
          data: [
            ...pState.data, //기존에 잇는 데이터에
            ...resp.data, //새로운 데이터 추가
          ],
        );
      }
      else {
        state = resp; //맨처음 데이터 받아보자
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
