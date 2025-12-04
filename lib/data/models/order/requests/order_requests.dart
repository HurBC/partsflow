import 'package:partsflow/core/widgets/sort_tag_filter.dart';
import 'package:partsflow/core/network/query_params.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';

class ListOrders extends QueryParams {
  final List<OrderStatusChoices>? status;
  final SortTagSortingType? sortByCategory;
  final SortTagSortingType? sortBy;
  final SortTagSortingType? sortByEstimatedTicket;

  const ListOrders({
    this.status,
    this.sortByCategory,
    this.sortBy,
    this.sortByEstimatedTicket,
    super.limit,
    super.offset,
  });

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> params = {
      'limit': limit,
      'offset': offset,
      'status': status?.map((e) => e.toJson()).toList(),
    };

    if (sortBy != SortTagSortingType.none) {
      params.addEntries({"sort_by": sortBy}.entries);
    }

    if (sortByCategory != SortTagSortingType.none) {
      params.addEntries({'sort_by_category': sortByCategory}.entries);
    }

    if (sortByEstimatedTicket != SortTagSortingType.none) {
      params.addEntries(
        {'sort_by_estimated_ticket': sortByEstimatedTicket}.entries,
      );
    }

    params.removeWhere((_, value) => value == null);

    return params;
  }
}
