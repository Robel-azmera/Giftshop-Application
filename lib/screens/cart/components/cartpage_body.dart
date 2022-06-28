import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/controller/price_info_controller.dart';
import 'package:lezemed_mobile_app/global_widgets/custom_app_bar.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/cart/components/cartpage_contents.dart';
import 'package:lezemed_mobile_app/screens/cart/widgets/payement_infoSection.dart';

class CartPageScreenBody extends StatefulWidget {
  const CartPageScreenBody({Key key, this.model}) : super(key: key);
  final ProductModel model;

  @override
  _CartPageScreenBodyState createState() => _CartPageScreenBodyState();
}

class _CartPageScreenBodyState extends State<CartPageScreenBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<Box<PriceInfo>>(
          valueListenable: PriceInfoController.getPrice().listenable(),
          builder: (context, box, _) {
            final priceInfo = box.values.toList().cast<PriceInfo>();

            return Container(
              child: Column(
                children: [
                  ValueListenableBuilder<Box<Cart>>(
                      valueListenable: CartController.getCart().listenable(),
                      builder: (context, box, _) {
                        final cart = box.values.toList().cast<Cart>();

                        return customAppBar(
                            title: AppStrings.cart,
                            isRightIconVisible: false,
                            isLeftIconBack: true,
                            context: context,
                            amount: cart.length);
                      }),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  CartPageBuilder(
                    model: widget.model,
                    priceInfo: priceInfo,
                  ),
                  PayementInfoSection(
                    model: widget.model,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

typedef void IntCallback(int val);
typedef void IdCallback(int val);
// typedef void StringCallback(String val);
