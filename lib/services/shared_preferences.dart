import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService extends GetxService {
  SharedPreferences? _prefs;

  static SharedPreferencesService get find => Get.find<SharedPreferencesService>();

  SharedPreferencesService() {
    _getSharedPreferencesInstance();
  }

  Future<void> add(String key, String value) async => await _prefs!.setString(key, value);

  String? get(String key) => _prefs!.getString(key);

  Future<void> removeKey(key) async => await _prefs!.remove(key);

  Future<SharedPreferences> _getSharedPreferencesInstance() async => _prefs ??= await SharedPreferences.getInstance();

  void clearAllSavedData() => _prefs!.getKeys().forEach((element) {
        _prefs!.remove(element);
      });
}
