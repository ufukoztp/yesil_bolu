import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static const String prefsLanguage = "lang";

  static void saveLanguage(Locale locale) {
    SharedPreferences.getInstance().then((prefs) {
      String curLang = prefs.getString(prefsLanguage) ?? "";
      if (curLang != locale.languageCode) {
        prefs.setString(prefsLanguage, locale.languageCode);
      }
    });
  }

  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefsLanguage) ?? "en";
  }
}