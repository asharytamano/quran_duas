import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<List<dynamic>> loadJsonList(String assetPath) async {
  final raw = await rootBundle.loadString(assetPath);
  return json.decode(raw) as List<dynamic>;
}

String surahKey(int number, String nameEn) => '$number — $nameEn';
