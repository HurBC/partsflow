import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String? partsflowUrl = dotenv.env["PARTSFLOW_API_URL"];

}
