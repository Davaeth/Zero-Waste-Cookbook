import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Translator {
  static const String _languageKey = 'language';

  static Translator _instance = Translator._internal();
  static Map<String, String> _translatedData;

  static Translator get instance => _instance;

  factory Translator() {
    if (_instance == null) {
      _instance = Translator();

      return _instance;
    }

    return _instance;
  }

  Translator._internal() {
    _translate();
  }

  String getTranslation(String key) => _translatedData[key];

  Future<void> setLanguageType(String languageType) async {
    var _sharedPreferences = await SharedPreferences.getInstance();

    await _sharedPreferences.setString(_languageKey, languageType);
  }

  Future<void> _translate() async {
    var _sharedPreferences = await SharedPreferences.getInstance();

    if (!_sharedPreferences.containsKey(_languageKey)) {
      await _sharedPreferences.setString(_languageKey, 'en');
    }

    var _languageCode = _sharedPreferences.getString(_languageKey);

    String _translation;

    _translation =
        await rootBundle.loadString('assets/lang/$_languageCode.json');

    Map<String, dynamic> _jsonTranslation = json.decode(_translation);

    _translatedData = _jsonTranslation.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }
}
