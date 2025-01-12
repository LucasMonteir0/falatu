import 'package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesServiceImpl implements SharedPreferencesService {
  SharedPreferencesServiceImpl() {
    init();
  }

  SharedPreferences? _prefs;

  @override
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  String? getUserAccessToken() {
    if (_prefs == null) {
      return null;
    }
    final token = _prefs!.getString('accessToken');
    return token;
  }

  @override
  String? getUserRefreshToken() {
    if (_prefs == null) {
      return null;
    }
    final token = _prefs!.getString('refreshToken');
    return token;
  }

  @override
  Future<bool> setUserAccessToken(String token) async {
    if (_prefs == null) {
      return false;
    }
    final isSaved = await _prefs!.setString('accessToken', token);
    return isSaved;
  }

  @override
  Future<bool> setUserRefreshToken(String token) async {
    if (_prefs == null) {
      return false;
    }
    final isSaved = await _prefs!.setString('refreshToken', token);
    return isSaved;
  }
}
