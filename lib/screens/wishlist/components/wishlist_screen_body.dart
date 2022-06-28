import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/controller/wishlist_controller.dart';
import 'package:lezemed_mobile_app/global_widgets/custom_app_bar.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/models/wishlist.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/wishlist/components/wishlist_screen_content.dart';

class WishListPageScreenBody extends StatefulWidget {
  const WishListPageScreenBody({Key key, this.model}) : super(key: key);

  final ProductModel model;

  @override
  _WishListPageScreenBodyState createState() => _WishListPageScreenBodyState();
}

class _WishListPageScreenBodyState extends State<WishListPageScreenBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<Box<Wishlist>>(
          valueListenable: WishlistController.getWishlist().listenable(),
          builder: (context, box, _) {
            final wishlists = box.values.toList().cast<Wishlist>();
            return buildContent(wishlists);
          },
        ),
      ),
    );
  }

  Widget buildContent(List<Wishlist> wishlists) {
    return Container(
      child: Column(
        children: [
          ValueListenableBuilder<Box<Cart>>(
              valueListenable: CartController.getCart().listenable(),
              builder: (context, box, _) {
                final cart = box.values.toList().cast<Cart>();
                return customAppBar(
                    title: AppStrings.wishlist,
                    isRightIconVisible: true,
                    isLeftIconBack: false,
                    context: context,
                    amount: cart.length);
              }),
          SizedBox(
            height: getProportionateScreenHeight(20.0),
          ),
          wishListPageResultsBuilder(model: widget.model),
        ],
      ),
    );
  }
}
