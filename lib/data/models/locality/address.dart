class Commune {
  final int id;
  final String name;
  final String region;
  final String country;

  Commune({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
  });

  factory Commune.fromJson(Map<String, dynamic> json) => Commune(
        id: json["id"],
        name: json["name"],
        region: json["region"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region": region,
        "country": country,
      };
}

class AddressRepository {
  final int id;
  final String label;
  final String streetName;
  final int streetNumber;
  final String localNumber;
  final String fullAddress;
  final Commune commune;

  AddressRepository({
    required this.id,
    required this.label,
    required this.streetName,
    required this.streetNumber,
    required this.localNumber,
    required this.fullAddress,
    required this.commune,
  });

  factory AddressRepository.fromJson(Map<String, dynamic> json) => AddressRepository(
        id: json["id"],
        label: json["label"],
        streetName: json["street_name"],
        streetNumber: json["street_number"],
        localNumber: json["local_number"],
        fullAddress: json["full_address"],
        commune: Commune.fromJson(json["commune"]),
      );

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
