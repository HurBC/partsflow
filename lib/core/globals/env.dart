import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String? get partsflowUrl => dotenv.env["PARTSFLOW_API_URL"];

}
