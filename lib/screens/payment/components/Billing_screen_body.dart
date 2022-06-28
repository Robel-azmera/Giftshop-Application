import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/global_widgets/custom_app_bar.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/scoped_model/order_model.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/payment/components/billing_screen_contents.dart';

class PaymentPageScreenBody extends StatefulWidget {
  final OrderModel orderModel;
  final ProductModel model;

  PaymentPageScreenBody({
    @required this.orderModel,
    @required this.model,
  });
  @override
  _PaymentPageScreenBodyState createState() => _PaymentPageScreenBodyState();
}

class _PaymentPageScreenBodyState extends State<PaymentPageScreenBody> {
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
                      title: AppStrings.payment,
                      isRightIconVisible: true,
                      isLeftIconBack: true,
                      context: context,
                      amount: cart.length,
                    );
                  }),
              scrollFieldsBuilder(
                orderModel: widget.orderModel,
                productModel: widget.model,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
