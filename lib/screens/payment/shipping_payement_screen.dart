import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/models/customer_detail_model.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/payment/components/shipping_screen_body.dart';

class ShippingPayementPageScreen extends StatelessWidget {
  final Billing billingInfo;
  final ProductModel productModel;

  const ShippingPayementPageScreen({
    Key key,
    @required this.billingInfo,
    @required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: ShippingPaymentPageScreenBody(
        billingInfo: billingInfo,
        productModel: productModel,
      ),
    );
  }
}
