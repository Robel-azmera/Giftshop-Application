import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/base/base_view.dart';
import 'package:lezemed_mobile_app/screens/cart/components/cartpage_body.dart';

class CartPageScreen extends StatefulWidget {
  //This is the main Search Page Widget
  @override
  _CartPageScreenState createState() => _CartPageScreenState();
}

class _CartPageScreenState extends State<CartPageScreen> {
  int _index = 0;

  set string(int value) => setState(() => _index = value);
  @override
  void dispose() {
    Hive.box('cartlist').close();
    Hive.box('price_info').close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: BaseView<ProductModel>(
          builder: (context, child, model) => CartPageScreenBody(model: model)),
    );
  }
}

typedef void IntCallback(int val);
