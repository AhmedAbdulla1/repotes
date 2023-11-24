
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

  // onBoarding
  void setPressKeyOnBoardingScreen(){
    _sharedPreferences.setBool(pressKeyOnBoardingScreen, true);
  }

  void setProfileImage(String image)  {
    _sharedPreferences.setString(profileImageKey, image);
  }

  Future<void> setWifiData(List<String> data ) async {
    _sharedPreferences.setStringList(profileImageKey, data);
  }
  List<String>? getWifiData() {
    return _sharedPreferences.getStringList(profileImageKey,);
  }
  Future<void> getProfileImage(String image) async {
    _sharedPreferences.getString(profileImageKey);
  }

  Future<bool> isPressKeyOnBoardingScreen() async {
    return _sharedPreferences.getBool(pressKeyOnBoardingScreen) ?? false;
  }

  Future<void> setTraining(List<String> trainingData) async {
    _sharedPreferences.setStringList(trainingKey, trainingData);
  }

  List<String>? getTraining() {
    return _sharedPreferences.getStringList(trainingKey);
  }

  //login
  Future<void> setPressKeyLoginScreen() async {
    _sharedPreferences.setBool(pressKeyLoginScreen, true);
  }

  Future<bool> isPressKeyLoginScreen() async {
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
    _sharedPreferences.setString(token, t);
  }

  String getToken() {
    return _sharedPreferences.getString(token) ?? '';
  }

  // logout
  Future<void> logout() {
    return _sharedPreferences.remove(pressKeyLoginScreen);
  }
}
