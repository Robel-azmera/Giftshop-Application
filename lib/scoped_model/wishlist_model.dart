import 'package:lezemed_mobile_app/scoped_model/base_model.dart';
import 'package:lezemed_mobile_app/controller/wishlist_controller.dart';

class WishlistModel extends BaseModel {
  Future getWishlist() async {
    // Start model
    return await WishlistController.getWishlist();
    // End model
  }
}
