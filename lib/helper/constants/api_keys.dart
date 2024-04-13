import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeys {
  static String baseUrl = dotenv.get("BASE_URL");
}
