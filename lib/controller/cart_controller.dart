import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/models/cart.dart';

class CartController {
  static Box<Cart> getCart() => Hive.box<Cart>('cart');
}
