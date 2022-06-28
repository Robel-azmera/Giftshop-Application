import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';

class PriceInfoController {
  static Box<PriceInfo> getPrice() => Hive.box<PriceInfo>('price_info');
}
