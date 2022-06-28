import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/models/customer_detail_model.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/payment/widgets/shipping_form.dart';

Widget shippingScrollFieldsBuilder(
    {Billing billingInfo, ProductModel productModel}) {
  return Expanded(
    flex: 1,
    child: ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: getProportionateScreenHeight(35),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(30),
          ),
          child: Text(
            AppStrings.shippingInformation,
            style: TextStyle(
              fontSize: 23,
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        ShippingForm(
          billingInfo: billingInfo,
          productModel: productModel,
        ),
      ],
    ),
  );
}
