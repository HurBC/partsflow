import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/core/models/list_api_response.dart';
import 'package:partsflow/core/widgets/car/client_car_info.dart';
import 'package:partsflow/core/widgets/card.dart';
import 'package:partsflow/data/abstract_models/cars/car.dart';
import 'package:partsflow/data/abstract_models/cars/client_car.dart';
import 'package:partsflow/data/requests/brand.dart';
import 'package:partsflow/data/requests/car.dart';
import 'package:partsflow/services/cars/car_service.dart';

class ClientCarSearch extends StatefulWidget {
  const ClientCarSearch({super.key});

  @override
  State<ClientCarSearch> createState() => _ClientCarSearchState();
}

class _ClientCarSearchState extends State<ClientCarSearch> {
  final _carPatternController = TextEditingController();

  bool _isLoading = false;
  ClientCar<Car<int>>? _clientCar;

  Future<void> _getClientCar() async {
    setState(() {
      _isLoading = true;
    });

    SearcClientCarParams params = SearcClientCarParams(
      limit: 1000,
      offset: 0,
      query: _carPatternController.text,
    );

    ListApiResponse<ClientCar<Car<int>>> data = await CarService.searcClientCar(
      params,
    );

    debugPrint("CLIENT CAR ${data.results}");

    setState(() {
      _isLoading = false;

      if (data.results.isNotEmpty) {
        _clientCar = data.results.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: PartsflowColors.backgroundDark);
    var widgetStatePropertyAll = WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(6)),
    );

    if (_clientCar != null) {
      return ClientCarInfo(clientCar: _clientCar!);
    } else {
      return RCard(
        cardBgColor: PartsflowColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Buscar vehiculo del cliente"),
            TextField(
              controller: _carPatternController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: "Ej: HPKP10",
                prefixIcon: Icon(Icons.directions_car),
              ),
            ),
            if (_carPatternController.text.isNotEmpty &&
                _carPatternController.text.length >= 6)
              SizedBox(
                child: Row(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _carPatternController.clear();
                          setState(() {});
                        },
                        style: ButtonStyle(
                          shape: widgetStatePropertyAll,
                          backgroundColor: WidgetStateProperty.all(
                            Colors.redAccent,
                          ),
                        ),
                        child: const Text("Cancelar", style: textStyle),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _getClientCar,
                        style: ButtonStyle(
                          shape: widgetStatePropertyAll,
                          backgroundColor: WidgetStateProperty.all(
                            PartsflowColors.primaryLight,
                          ),
                        ),
                        child: Text(
                          !_isLoading ? "Buscar" : "Buscando...",
                          style: textStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    }
  }
}
