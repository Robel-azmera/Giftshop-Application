import 'dart:convert';

import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/controller/wishlist_controller.dart';
import 'package:lezemed_mobile_app/scoped_model/base_model.dart';

class CartModel extends BaseModel {
  Future getCart() async {
    // Start model
    return await CartController.getCart();
    // End model
  }
}
