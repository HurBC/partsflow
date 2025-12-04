import 'package:flutter/material.dart';
import 'package:partsflow/core/widgets/card.dart';
import 'package:partsflow/data/abstract_models/cars/car.dart';
import 'package:partsflow/data/abstract_models/cars/client_car.dart';

class ClientCarInfo extends StatelessWidget {
  final ClientCar<Car<int>> clientCar;

  const ClientCarInfo({super.key, required this.clientCar});

  @override
  Widget build(BuildContext context) {
    const carRowSpacer = SizedBox(height: 4);

    return RCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Informacion del Vehiculo:", style: TextStyle(fontSize: 18.0),),
              Icon(Icons.directions_car),
            ],
          ),
          carRowSpacer,
          carInfoRow(key: "Marca", value: clientCar.car?.brand.toString()),
          carRowSpacer,
          carInfoRow(key: "Modelo", value: clientCar.car?.model.toString()),
          carRowSpacer,
          carInfoRow(key: "Versión", value: clientCar.car?.version.toString()),
          carRowSpacer,
          carInfoRow(
            key: "Cilindrada",
            value: clientCar.car?.displacement.toString(),
          ),
          carRowSpacer,
          carInfoRow(key: "Año", value: clientCar.car?.year.toString()),
          carRowSpacer,
          carInfoRow(key: "Patente", value: clientCar.plate.toString()),
          carRowSpacer,
          carInfoRow(
            key: "Número Motor",
            value: clientCar.motorNumber.toString(),
          ),
          carRowSpacer,
          carInfoRow(key: "VIN", value: clientCar.vin.toString()),
        ],
      ),
    );
  }

  Row carInfoRow({required String key, String? value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(key), Text(value ?? "")],
    );
  }
}
