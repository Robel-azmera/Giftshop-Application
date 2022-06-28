import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/global_widgets/custom_app_bar.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/screens/shop/components/shop_body.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Shop extends StatelessWidget {
  final String inheritedCategoryId;
  const Shop({Key key, this.inheritedCategoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              ValueListenableBuilder<Box<Cart>>(
                  valueListenable: CartController.getCart().listenable(),
                  builder: (context, box, _) {
                    final cart = box.values.toList().cast<Cart>();
                    return customAppBar(
                      title: AppStrings.shop,
                      isRightIconVisible: true,
                      isLeftIconBack:
                          inheritedCategoryId != null ? true : false,
                      context: context,
                      amount: cart.length,
                    );
                  }),
              ShopBody(inheritedCategoryId: inheritedCategoryId),
            ],
          ),
        ),
      ),
    );
  }
}
