import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/orders_colors.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/core/components/card.dart';
import 'package:partsflow/data/models/cars/client_car.dart';
import 'package:partsflow/data/models/order/order.dart';
import 'package:partsflow/services/cars/supplier_car_service.dart';
import 'package:partsflow/services/orders/orders_service.dart';

class OrderDetailInfo extends StatefulWidget {
  final int orderId;

  const OrderDetailInfo({super.key, required this.orderId});

  @override
  State<OrderDetailInfo> createState() => _OrderDetailInfoState();
}

class _OrderDetailInfoState extends State<OrderDetailInfo> {
  OrderDetailRespository? _orderDetail;
  ClientCarCarRepository? _clientCarDetails;
  Color _categoryTagColor = PartsflowColors.primaryLight2;
  Color _categoryTagBorderColor = PartsflowColors.primaryLight2;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadOrderDetails();
  }

  Future<void> _loadClientCarDetails() async {
    if (_orderDetail == null) return;
    if (_orderDetail?.clientCar == null) return;

    setState(() {
      _isLoading = true;
    });

    final data = await SupplierCarService.getClientCar(
      clientCarId: _orderDetail!.clientCar,
    );

    setState(() {
      _clientCarDetails = data;
      _isLoading = false;
    });
  }

  Future<void> _loadOrderDetails() async {
    final data = await OrdersService.getOrder(orderId: widget.orderId);

    Color? categoryTagColor, categoryTagBorderColor;

    switch (data.estimatedCategory) {
      case "gold":
        categoryTagColor = OrdersColors.goldGradient[0];
        categoryTagBorderColor = OrdersColors.goldBorder;

        break;
      case "silver":
        categoryTagColor = OrdersColors.silverGradient[0];
        categoryTagBorderColor = OrdersColors.silverBorder;

        break;
      case "bronze":
        categoryTagColor = OrdersColors.bronzeGradient[0];
        categoryTagBorderColor = OrdersColors.bronzeBorder;

        break;
      case "trash":
        categoryTagColor = OrdersColors.trashGradient[0];
        categoryTagBorderColor = OrdersColors.trashBorder;

        break;

      default:
        categoryTagColor = PartsflowColors.primaryLight2;
        categoryTagBorderColor = PartsflowColors.backgroundDark;

        break;
    }

    setState(() {
      _orderDetail = data;
      _isLoading = false;

      if (categoryTagColor != null && categoryTagBorderColor != null) {
        _categoryTagColor = categoryTagColor;
        _categoryTagBorderColor = categoryTagBorderColor;
      }
    });

    _loadClientCarDetails();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 18.0);

    const cardSpacer = SizedBox(height: 6);
    const carRowSpacer = SizedBox(height: 4);
    var orderCategoryTextStyle = TextStyle(
      fontSize: 18.0,
      color: _categoryTagBorderColor,
    );

    return _isLoading
        ? const Text("Cargando informacion del pedido...", style: textStyle)
        : Container(
            color: PartsflowColors.background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Informacion del pedido", style: textStyle),
                      const Spacer(),
                      Text(
                        _orderDetail?.createdAt.split("T")[0] ?? "",
                        style: textStyle,
                      ),
                    ],
                  ),
                  cardSpacer,
                  RCard(
                    cardBgColor: _categoryTagColor,
                    cardBorderColor: _categoryTagBorderColor,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pedido ${_orderDetail?.estimatedCategory ?? ""}",
                              style: orderCategoryTextStyle,
                            ),
                            Text(
                              "\$${_orderDetail?.estimatedTicket ?? 0}",
                              style: orderCategoryTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  cardSpacer,
                  RCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Informacion del vehiculo",
                          style: textStyle,
                        ),
                        carRowSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Marca"),
                            Text(
                              "${_clientCarDetails?.carDetails.brand ?? ""}",
                            ),
                          ],
                        ),
                        carRowSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Modelo"),
                            Text("${_clientCarDetails?.carDetails.model}"),
                          ],
                        ),
                        carRowSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Version"),
                            Text("${_clientCarDetails?.carDetails.version}"),
                          ],
                        ),
                        carRowSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Clindrada"),
                            Text(
                              "${_clientCarDetails?.carDetails.displacement}",
                            ),
                          ],
                        ),
                        carRowSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Año"),
                            Text("${_clientCarDetails?.carDetails.year}"),
                          ],
                        ),
                        carRowSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Patente"),
                            Text("${_clientCarDetails?.plate}"),
                          ],
                        ),
                        carRowSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Numero Motos"),
                            Text("${_clientCarDetails?.motorNumber}"),
                          ],
                        ),
                        carRowSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("VIN"),
                            Text("${_clientCarDetails?.vin}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
