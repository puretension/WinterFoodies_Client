import 'package:flutter/material.dart';
import 'package:winter_foodies/common/provider/pagination_provider.dart';


class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider,
  }) {
    if (controller.offset > controller.position.maxScrollExtent - 30) {
      provider.paginate(
        fetchMore: true,
      );
    }
  }
}
