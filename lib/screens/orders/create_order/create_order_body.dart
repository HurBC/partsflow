import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/core/components/card.dart';

class CreateOrderBody extends StatefulWidget {
  const CreateOrderBody({super.key});

  @override
  State<CreateOrderBody> createState() => _CreateOrderBodyState();
}

const CLIENT_LIST = [
  (id: 1, name: 'Cliente A'),
  (id: 2, name: 'Cliente B'),
  (id: 3, name: 'Cliente C'),
  (id: 4, name: 'Cliente D'),
];

class _CreateOrderBodyState extends State<CreateOrderBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          RCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vehiculo del pedido",
                  style: TextStyle(
                    color: PartsflowColors.backgroundDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Ingrese el patente del vehículo",
                  ),
                ),
              ],
            ),
          ),
          RCard(
            borderRadius: 5.0,
            cardBgColor: PartsflowColors.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cliente",
                  style: TextStyle(
                    color: PartsflowColors.backgroundDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton(
                  hint: Text("Seleccione un cliente"),
                  items: CLIENT_LIST.map((client) {
                    return DropdownMenuItem<int>(
                      value: client.id,
                      child: Text(client.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    debugPrint("Cliente seleccionado: $value");
                  },
                ),
              ],
            ),
          ),
          RCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Productos",
                  style: TextStyle(
                    color: PartsflowColors.backgroundDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Aquí puedes agregar la lógica para seleccionar productos
              ],
            ),
          ),
        ],
      ),
    );
  }
}
