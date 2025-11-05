import 'dart:math';

import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/core/components/client_image.dart';
import 'package:partsflow/core/components/tag.dart';
import 'package:partsflow/core/utils/time_utils.dart';
import 'package:partsflow/data/models/clients/client_kanban.dart';
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
    const double IMAGE_SIZE = 50;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: PartsflowColors.primaryLight2,
        borderRadius: BorderRadius.circular(8),
        border: BoxBorder.all(color: PartsflowColors.primaryLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Tag(
                      title: "#${_order.id}",
                      padding: 1.5,
                      borderColor: PartsflowColors.primaryLight,
                      borderRadius: 4,
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: PartsflowColors.backgroundDark,
                      ),
                    ),
                    Text("${_order.clientCarDetails?.plate}"),
                  ],
                ),
                Spacer(),
                Text(
                  getElapsedTime(_order.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: PartsflowColors.backgroundDark,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            getOpqsList(_order.opqs),
            Divider(color: PartsflowColors.primaryLight),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _order.clientDetails != null
                  ? clientDetails(IMAGE_SIZE, _order.clientDetails!)
                  : null,
            ),
            Text(
              "${_order.clientCarDetails?.name?.split("-")[0].trim()}",
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Container clientDetails(
    double IMAGE_SIZE,
    ClientKanbanRepository clientDetails,
  ) {
    final fullName = clientDetails.fullName;
    final clientName = fullName != null
        ? fullName.substring(0, min(8, fullName.length))
        : '';

    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: PartsflowColors.primaryLight),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            ClientImage(
              profilePictureUrl: clientDetails.profilePictureUrl,
              imageSize: IMAGE_SIZE,
            ),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      clientName,
                      style: TextStyle(color: PartsflowColors.backgroundDark),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${clientDetails.phone}",
                      style: TextStyle(color: PartsflowColors.backgroundDark),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                  width: 270,
                  child: Text(
                    "${clientDetails.lastMessage}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox getOpqsList(List<OrderProductQuantityRepository> opqs) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: opqs.length,
        itemBuilder: (builder, index) => Padding(
          padding: const EdgeInsets.all(2),
          child: Tag(
            title: opqs[index].product.name,
            borderRadius: 2,
            color: PartsflowColors.primaryLight3,
            borderColor: PartsflowColors.primaryLight,
            textStyle: TextStyle(color: PartsflowColors.backgroundDark),
          ),
        ),
      ),
    );
  }
}
