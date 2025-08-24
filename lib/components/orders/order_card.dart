import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/core/components/tag.dart';
import 'package:partsflow/core/utils/time_utils.dart';
import 'package:partsflow/data/models/order/order.dart';
import 'package:partsflow/data/models/order/order_product_quantity.dart';

class OrderCard extends StatefulWidget {
  final KanbanOrderRepository order;

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late KanbanOrderRepository _order;

  @override
  void initState() {
    super.initState();

    _order = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: PartsflowColors.background,
        borderRadius: BorderRadius.circular(3),
        border: BoxBorder.all(color: Colors.grey.shade600),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            Row(
              children: [
                Text("#${_order.id}"),
                Spacer(),
                Text(
                  getElapsedTime(_order.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: PartsflowColors.secondaryDark,
                  ),
                ),
              ],
            ),
            Text("ORDER INFO"),
            Column(children: [getOpqsList(_order.opqs)]),
          ],
        ),
      ),
    );
  }

  SizedBox getOpqsList(List<OrderProductQuantityRepository> opqs) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: opqs.length,

        itemBuilder: (builder, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Tag(
            title: opqs[index].product.name,
            color: PartsflowColors.backgroundSemiDark,
          ),
        ),
        //Text(
        //  "ORDER OPQ ID: ${opqs[index].id} PRODUCT ${opqs[index].product.name}",
        //),
      ),
    );
  }
}
