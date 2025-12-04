import 'package:partsflow/core/network/query_params.dart';

class ListCarBrand extends QueryParams {
  int? id;
  String? name;
  String? country;
  bool? isLightVehicle;
  String? createdAt;
  String? updatedAt;

  ListCarBrand({
    this.id,
    this.name,
    this.country,
    this.isLightVehicle,
    this.createdAt,
    this.updatedAt,
    super.limit,
    super.offset
  });

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> params = {
      'limit': limit,
      'offset': offset,
      'id': id,
      "name": name,
      "country": country,
      "isLightVehicle": isLightVehicle,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };

    params.removeWhere((_, value) => value == null);

    return params;
  }

}
