import 'package:lezemed_mobile_app/scoped_model/base_model.dart';
import 'package:lezemed_mobile_app/scoped_model/home_model.dart';
import 'package:lezemed_mobile_app/scoped_model/utility_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedModel extends Model with BaseModel, HomeModel, UtilityModel {}
