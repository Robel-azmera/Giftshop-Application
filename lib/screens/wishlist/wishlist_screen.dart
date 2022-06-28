import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/base/base_view.dart';
import 'package:lezemed_mobile_app/screens/wishlist/components/wishlist_screen_body.dart';

class WishListPageScreen extends StatefulWidget {
  const WishListPageScreen({Key key}) : super(key: key);

  @override
  _WishListPageScreenState createState() => _WishListPageScreenState();
}

class _WishListPageScreenState extends State<WishListPageScreen> {
  @override
  void dispose() {
    Hive.box('wishlist').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BaseView<ProductModel>(
          builder: (context, child, model) =>
              WishListPageScreenBody(model: model)),
    );
  }
}
