import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:partsflow/data/rerpositories/user_rerpository.dart";

class Repository {
  final String? partsflowUrl = dotenv.env["PARTSFLOW_API_URL"];
  late final UserRerpository users;

  Repository() {
    users = UserRerpository(partsflowUrl: partsflowUrl);
  }
}
