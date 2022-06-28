import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/controller/payment_controller.dart';
import 'package:lezemed_mobile_app/controller/price_info_controller.dart';
import 'package:lezemed_mobile_app/enums/view_state.dart';
import 'package:lezemed_mobile_app/global_widgets/alert_dialog.dart';
import 'package:lezemed_mobile_app/global_widgets/check_busy_state.dart';
import 'package:lezemed_mobile_app/global_widgets/custom_app_bar.dart';
import 'package:lezemed_mobile_app/global_widgets/spinners.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/models/customer_detail_model.dart';
import 'package:lezemed_mobile_app/models/order.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';
import 'package:lezemed_mobile_app/scoped_model/order_model.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/payment/components/shipping_screen_contents.dart';

class ShippingPaymentPageScreenBody extends StatefulWidget {
  final Billing billingInfo;
  final ProductModel productModel;

  const ShippingPaymentPageScreenBody({
    Key key,
    @required this.billingInfo,
    @required this.productModel,
  }) : super(key: key);
  @override
  _ShippingPaymentPageScreenBodyState createState() =>
      _ShippingPaymentPageScreenBodyState();
}

class _ShippingPaymentPageScreenBodyState
    extends State<ShippingPaymentPageScreenBody> {
  @override
  initState() {
    super.initState();

    StripeService.init();
  }

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
              shippingScrollFieldsBuilder(
                billingInfo: widget.billingInfo,
                productModel: widget.productModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Credit Card - PayPal : Section
class CustomPaymentWidget extends StatefulWidget {
  final Order order;
  final GlobalKey<FormState> formKey;
  final ProductModel productModel;

  const CustomPaymentWidget({
    Key key,
    @required this.order,
    @required this.formKey,
    @required this.productModel,
  }) : super(key: key);

  @override
  _CustomPaymentWidgetState createState() => _CustomPaymentWidgetState();
}

class _CustomPaymentWidgetState extends State<CustomPaymentWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _groupValue;
  bool _isCreditCard = true;
  bool isProcessingPayment = false;

  @override
  void initState() {
    setState(() {
      _groupValue = "creditcard";
    });
    super.initState();
  }

  void onPayPalSelected(String value) {
    setState(() {
      _groupValue = value;
      bool _isCreditCard = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<PriceInfo>>(
        valueListenable: PriceInfoController.getPrice().listenable(),
        builder: (context, box, _) {
          final val = box.values.toList().cast<PriceInfo>();
          int _total = 0;
          int variationId = 0;

          for (var i = 0; i < val.length; i++) {
            if (val[i] != null) {
              _total += val[i].amount * val[i].price;
            }
          }
          Future<bool> payWithCard() async {
            var response = await StripeService.payWithNewCard(
                amount: _total.toString(), currency: 'USD');

            if (response.success) {
              return true;
            }
            return false;
          }

          return ValueListenableBuilder<Box<PriceInfo>>(
            valueListenable: PriceInfoController.getPrice().listenable(),
            builder: (context, box, _) {
              final val = box.values.toList().cast<PriceInfo>();
              return Container(
                decoration: BoxDecoration(
                  gradient: kPrimaryFromTopToBottomGradientColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(5.0),
                      vertical: getProportionateScreenHeight(5.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: 'creditcard',
                                    groupValue: _groupValue,
                                    activeColor: Colors.white,
                                    onChanged: (val) {
                                      _groupValue = val;
                                      setState(() {
                                        _isCreditCard = true;
                                      });
                                      print('$_groupValue');
                                    },
                                  ),
                                  Text(
                                    AppStrings.creditCard,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/visa.png',
                                  width: getProportionateScreenWidth(20),
                                  height: getProportionateScreenHeight(20),
                                ),
                                SizedBox(
                                    width: getProportionateScreenWidth(5.0)),
                                Image.asset(
                                  'assets/images/american_express.png',
                                  width: getProportionateScreenWidth(20),
                                  height: getProportionateScreenHeight(20),
                                ),
                                SizedBox(
                                    width: getProportionateScreenWidth(5.0)),
                                Image.asset(
                                  'assets/images/master_card.png',
                                  width: getProportionateScreenWidth(20),
                                  height: getProportionateScreenHeight(20),
                                ),
                                SizedBox(
                                    width: getProportionateScreenWidth(5.0)),
                                Image.asset(
                                  'assets/images/discover.png',
                                  width: getProportionateScreenWidth(20),
                                  height: getProportionateScreenHeight(20),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                AppStrings.poweredBy,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                AppStrings.stripe,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(13.0),
                        ),
                        // Theme(
                        //   data: ThemeData(
                        //     unselectedWidgetColor: Colors.white,
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Radio(
                        //         value: 'paypal',
                        //         groupValue: _groupValue,
                        //         activeColor: Colors.white,
                        //         onChanged: (val) {
                        //           _groupValue = val;
                        //           setState(() {
                        //             _isCreditCard = false;
                        //           });
                        //           if (_isCreditCard)
                        //             Fluttertoast.showToast(
                        //                 msg: "We didn't accept PayPal payment currently.",
                        //                 toastLength: Toast.LENGTH_SHORT,
                        //                 gravity: ToastGravity.BOTTOM,
                        //                 timeInSecForIosWeb: 1,
                        //                 backgroundColor: Colors.grey[200],
                        //                 textColor: kPrimaryColor,
                        //                 fontSize: 16.0);
                        //         },
                        //       ),
                        //       Text(
                        //         AppStrings.payPal,
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 19,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: getProportionateScreenHeight(10.0),
                        ),
                        Container(
                          width: getProportionateScreenWidth(290.0),
                          height: getProportionateScreenHeight(65.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: isProcessingPayment
                                ? Spinners(size: 26.0, color: kSecondaryColor)
                                : ElevatedButton(
                                    onPressed: () async {
                                      _total *= 100;
                                      if (_isCreditCard == true &&
                                          widget.formKey.currentState
                                              .validate()) {
                                        if (widget.order.shipping.country ==
                                                null ||
                                            widget.order.shipping.state ==
                                                null ||
                                            widget.order.shipping.city == null)
                                          return Fluttertoast.showToast(
                                              msg:
                                                  "Country, state or city are not filled.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey[200],
                                              textColor: kPrimaryColor,
                                              fontSize: 16.0);

                                        if (widget.order.shipping.country !=
                                            "Ethiopia")
                                          return Fluttertoast.showToast(
                                              msg:
                                                  "We only deliver products and gifts in Ethiopia",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey[200],
                                              textColor: kPrimaryColor,
                                              fontSize: 16.0);

                                        // if (widget.order.shipping.firstName
                                        //         .isEmpty ||
                                        //     widget.order.shipping.lastName
                                        //         .isEmpty ||
                                        //     widget.order.shipping.address1
                                        //         .isEmpty ||
                                        //     widget
                                        //         .order.shipping.city.isEmpty ||
                                        //     widget.order.shipping.country
                                        //         .isEmpty ||
                                        //     widget
                                        //         .order.shipping.state.isEmpty ||
                                        //     widget.order.shipping.postcode
                                        //         .isEmpty) {
                                        //   return Fluttertoast.showToast(
                                        //       msg:
                                        //           "Please revise your order information",
                                        //       toastLength: Toast.LENGTH_SHORT,
                                        //       gravity: ToastGravity.BOTTOM,
                                        //       timeInSecForIosWeb: 1,
                                        //       backgroundColor: Colors.grey[200],
                                        //       textColor: kPrimaryColor,
                                        //       fontSize: 16.0);
                                        // }


                                        setState(() {
                                          isProcessingPayment = true;
                                        });

                                        var orderResponse = await OrderModel()
                                            .createOrder(widget.order, val);

                                        if (orderResponse) {
                                          var response = await StripeService
                                              .payWithNewCard(
                                            amount: _total.toString(),
                                            currency: 'USD',
                                          );
                                          if (response.success == true) {
                                            setState(() {
                                              isProcessingPayment = false;
                                            });
                                            _buildPaymentSuccessAlert(
                                              context: context,
                                              message:
                                                  "Order placed successfuly. We will arrange your order based on your quene",
                                              productModel: widget.productModel,
                                            );
                                          } else {
                                            setState(() {
                                              isProcessingPayment = false;
                                            });
                                            _buildPaymentFailedAlert(
                                              context: context,
                                              message:
                                                  "Failed to make payment. Please try again with appropriate payment information",
                                            );
                                          }
                                        } else {
                                          setState(() {
                                            isProcessingPayment = false;
                                          });
                                          _buildPaymentFailedAlert(
                                            context: context,
                                            message:
                                                "Failed to make order. Please try again with appropriate order information",
                                          );
                                        }
                                        // var response =
                                        //     await StripeService.payWithNewCard(
                                        //   amount: _total.toString(),
                                        //   currency: 'USD',
                                        // );
                                        // if (response.success == true) {
                                        //   var orderResponse = await OrderModel()
                                        //       .createOrder(widget.order, val);
                                        //   if (orderResponse)
                                        //     _buildPaymentSuccessAlert(
                                        //       context: context,
                                        //       message:
                                        //           "Order placed successfuly. We will arrange your order based on your quene",
                                        //       productModel: widget.productModel,
                                        //     );
                                        //   else
                                        //     _buildPaymentFailedAlert(
                                        //       context: context,
                                        //       message: response.message,
                                        //     );
                                        // } else {
                                        //   _buildPaymentFailedAlert(
                                        //     context: context,
                                        //     message: response.message,
                                        //   );
                                        // }

                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: _isCreditCard
                                          ? MaterialStateProperty.all<Color>(
                                              kBackgroundColor)
                                          : MaterialStateProperty.all<Color>(
                                              Colors.amber),
                                    ),
                                    child: _isCreditCard
                                        ? Text(
                                            AppStrings.placeAnOrder,
                                            style: TextStyle(
                                              color: kSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0,
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Pay',
                                                style: TextStyle(
                                                  color: Colors.blue[800],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                              Text(
                                                'Pal',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}

_buildPaymentFailedAlert({BuildContext context, String message}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(
          title: 'Failed to Place Order',
          message: message,
          type: 'WARNING',
          context: context,
          isFromPayment: true,
          paymentStatus: "FAILED",
        );
      });
}

_buildPaymentSuccessAlert(
    {BuildContext context, String message, ProductModel productModel}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialogWidget(
          title: 'Order Successfully',
          message: message,
          type: 'success',
          context: context,
          productModel: productModel,
          isFromPayment: true,
          paymentStatus: "SUCCESS",
        );
      });
}
