import 'package:lezemed_mobile_app/controller/utility_controller.dart';
import 'package:lezemed_mobile_app/scoped_model/base_model.dart';
import 'package:lezemed_mobile_app/service_locator.dart';

class UtilityModel extends BaseModel {
  UtilityController utilityController = locator<UtilityController>();

  bool isDarkModeEnabled = false;

  void switchDarkMode(bool value) async {
    isDarkModeEnabled = await utilityController.switchDarkMode(value);
    notifyListeners();
  }
}
