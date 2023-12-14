
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_manager.dart';

const String prefsKeyLang = "PrefsKeyLang";
const String pressKeyOnBoardingScreen = 'PressKeyOnBoardingScreen';
const String pressKeyLoginScreen = 'PressKeyLoginScreen';
const String profileImageKey = 'profileImage';
const String wifiKey = 'Wifi';
const String exerciseKey = "ExerciseKey";
const String trainingKey = "TrainingKey";
const String token = "token";
const String password = "password";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    // ignore: unnecessary_null_comparison
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.arabic.getValue()) {
      _sharedPreferences.setString(prefsKeyLang, LanguageType.english.getValue());
    } else {
      _sharedPreferences.setString(prefsKeyLang, LanguageType.arabic.getValue());
    }
  }

  // Future<Locale> getLocale() async {
  //   String currentLang = await getAppLanguage();
  //   if (currentLang == LanguageType.arabic.getValue()) {
  //     return arabicLocale;
  //   } else {
  //     return englishLocale;
  //   }
  // }



  Future<void> setWifiData(List<String> data ) async {
    _sharedPreferences.setStringList(profileImageKey, data);
  }









  //login
  Future<void> setPressKeyLoginScreen(bool b) async {
    _sharedPreferences.setBool(pressKeyLoginScreen, b);
  }

  bool isPressKeyLoginScreen() {
    return _sharedPreferences.getBool(pressKeyLoginScreen) ?? false;
  }

  // sign up screen
  Future<void> setPressKeySignupScreen() async {
    _sharedPreferences.setBool(pressKeyLoginScreen, true);
  }

  Future<bool> isPressKeySignupScreen() async {
    return _sharedPreferences.getBool(pressKeyLoginScreen) ?? false;
  }

  //token
  Future<void> setToken(String t) async {
   await _sharedPreferences.setString(token, t);
  }

  String getToken() {
    return _sharedPreferences.getString(token) ?? '';
  }
  Future<void> setPassword(String t) async {
    await _sharedPreferences.setString(password, t);
  }

  String getPassword() {
    return _sharedPreferences.getString(password) ?? '';
  }

  // logout
  Future<void> logout() {
    return _sharedPreferences.remove(pressKeyLoginScreen);
  }
}
