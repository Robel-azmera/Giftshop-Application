import 'package:shared_preferences/shared_preferences.dart';

class UtilityController {
  // Switch dark mode
  Future<bool> switchDarkMode(bool currentDarkModeStatus) async {
    // Checking if dark mode is already enabled
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool _checkDarkModeStatus = _prefs.getBool('isDarkModeEnabled');

    if (_checkDarkModeStatus) {
      await _prefs.setBool('isDarkModeEnabled', false);
      return currentDarkModeStatus = false;
    } else {
      await _prefs.setBool('isDarkModeEnabled', true);
      return currentDarkModeStatus = true;
    }
  }
}
