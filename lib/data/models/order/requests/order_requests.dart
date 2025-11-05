import 'package:partsflow/core/components/sort_tag_filter.dart';
import 'package:partsflow/core/network/query_params.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';

class ListOrders extends QueryParams {
  final List<OrderStatusChoices>? status;
  final SortTagSortingType? sortByCategory;
  final SortTagSortingType? sortByEstimatedTicket;

  const ListOrders({
    this.status,
    this.sortByCategory,
    this.sortByEstimatedTicket,
    super.limit,
    super.offset
  });

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> params = {
      'limit': limit,
      'offset': offset,
      'sort_by_category': sortByCategory?.name,
      'sort_by_estimated_ticket': sortByEstimatedTicket?.name,
      'status': status?.map((e) => e.name).toList(),
    };

    params.removeWhere((_, value) => value == null,);

    return params;
  }

  
}
