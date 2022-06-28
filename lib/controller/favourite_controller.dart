import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/models/favourite.dart';

//Controls the favourite icon of the wishlist indicator
//applies (related)  to product detail and shop page
class FavouriteController {
  static Box<Favourite> getfavourite() => Hive.box<Favourite>('favourite');
}
