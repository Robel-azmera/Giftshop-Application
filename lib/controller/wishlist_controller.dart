import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/models/wishlist.dart';

class WishlistController {
  static Box<Wishlist> getWishlist() => Hive.box<Wishlist>('wishlist');
}
