import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static Future<void> ensureInitialized() => dotenv.load(fileName: '.env');

  static String get apiUrl => dotenv.env['API_URL']!;
}
