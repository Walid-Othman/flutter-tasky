import 'package:shared_preferences/shared_preferences.dart';

class PrefrenseManger {
  static final PrefrenseManger _instans = PrefrenseManger._internal();

  PrefrenseManger._internal();

  factory PrefrenseManger() {
    return _instans;
  }

  late SharedPreferences _preferences;
  Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  getString(String key) {
    return _preferences.getString(key);
  }

getBool (String key){
  return _preferences.getBool(key);
}
setBool (String key,value){
  return _preferences.setBool(key, value);
}

getInt(key){
  return _preferences.getInt(key);
}

  remove ( Key){
    return _preferences.remove(Key);
  }
}
