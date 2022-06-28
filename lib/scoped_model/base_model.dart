import 'package:lezemed_mobile_app/enums/view_state.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model {
  ViewState _currentState;

  ViewState get currentState => _currentState;

  void setCurrentAppState(ViewState newState) {
    _currentState = newState;
    notifyListeners();
  }
}
