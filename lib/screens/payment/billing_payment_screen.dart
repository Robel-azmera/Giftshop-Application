import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/models/payment_method.dart';
import 'package:lezemed_mobile_app/scoped_model/order_model.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/base/base_view.dart';
import 'package:lezemed_mobile_app/screens/payment/components/billing_screen_body.dart';

class PayementPageScreen extends StatelessWidget {
  final ProductModel productModel;

  PayementPageScreen({@required this.productModel});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseView<OrderModel>(
      builder: (context, child, model) => Scaffold(
        body: PaymentPageScreenBody(
          orderModel: model,
          model: productModel,
        ),
      ),
    );
  }
}
