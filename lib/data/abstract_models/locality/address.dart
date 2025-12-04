import 'package:partsflow/core/models/json.dart';

abstract class Commune extends ToJson {
  int get id;
  String get name;
  String get region;
  String get country;
}

abstract class Address extends ToJson {
  int get id;
  String get label;
  String get streetName;
  int get streetNumber;
  String get localNumber;
  String get fullAddress;
  Commune get commune;
}
