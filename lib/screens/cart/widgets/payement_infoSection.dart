import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/controller/price_info_controller.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';

import 'package:lezemed_mobile_app/screens/payment/billing_payment_screen.dart';
import 'package:lezemed_mobile_app/util_functions/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PayementInfoSection extends StatefulWidget {
  final ProductModel model;

  PayementInfoSection({
    @required this.model,
  });

  @override
  _PayementInfoSectionState createState() => _PayementInfoSectionState();
}

class _PayementInfoSectionState extends State<PayementInfoSection> {
  List<int> x = [];
  int _total_price;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<PriceInfo>>(
        valueListenable: PriceInfoController.getPrice().listenable(),
        builder: (context, box, _) {
          final val = box.values.toList().cast<PriceInfo>();
          int _total = 0;

          for (var i = 0; i < val.length; i++) {
            if (val[i] != null) {
              _total += val[i].amount * val[i].price;
            }
          }

          return Container(
              child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20.0),
            ),
            decoration: BoxDecoration(
              gradient: kPrimaryFromTopToBottomGradientColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.subTotal,
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '\$ ${_total}',
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.shipping,
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        // '\$ ${widget.shipping}',
                        'FREE',
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.total,
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '\$ ${_total}',
                        style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                _total != 0
                    ? ElevatedButton(
                        onPressed: () {
                          Routes().navigation(
                              context,
                              PayementPageScreen(
                                productModel: widget.model,
                              ));
                        },
                        child: Text(
                          AppStrings.proccedToCheckout,
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 65, vertical: 20),
                          ),
                          elevation: MaterialStateProperty.all(0.0),
                          backgroundColor:
                              MaterialStateProperty.all(kBackgroundColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "No items in the cart",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey[200],
                              textColor: kPrimaryColor,
                              fontSize: 16.0);
                        },
                        child: Text(
                          AppStrings.proccedToCheckout,
                          style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 65, vertical: 20),
                          ),
                          elevation: MaterialStateProperty.all(0.0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
              ],
            ),
          ));
        });
  }
}
