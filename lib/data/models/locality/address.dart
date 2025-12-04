import 'package:partsflow/data/abstract_models/locality/address.dart';

class CommuneModel extends Commune {
  @override
  final int id;
  @override
  final String name;
  @override
  final String region;
  @override
  final String country;

  CommuneModel({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
  });

  factory CommuneModel.fromJson(Map<String, dynamic> json) => CommuneModel(
        id: json["id"],
        name: json["name"],
        region: json["region"],
        country: json["country"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region": region,
        "country": country,
      };
}

class AddressModel extends Address {
  @override
  final int id;
  @override
  final String label;
  @override
  final String streetName;
  @override
  final int streetNumber;
  @override
  final String localNumber;
  @override
  final String fullAddress;
  @override
  final Commune commune;

  AddressModel({
    required this.id,
    required this.label,
    required this.streetName,
    required this.streetNumber,
    required this.localNumber,
    required this.fullAddress,
    required this.commune,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        label: json["label"],
        streetName: json["street_name"],
        streetNumber: json["street_number"],
        localNumber: json["local_number"],
        fullAddress: json["full_address"],
        commune: CommuneModel.fromJson(json["commune"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "street_name": streetName,
        "street_number": streetNumber,
        "local_number": localNumber,
        "full_address": fullAddress,
        "commune": commune.toJson(),
      };
}
