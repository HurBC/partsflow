abstract class Car<BrandType> {
  int get id;
  String get model;
  String? get version;
  String? get displacement;
  String? get manufacturer;
  String? get firstMotorNumbers;
  String? get originCountry;
  String? get originalModel;
  int get year;

  BrandType? get brand;
}
