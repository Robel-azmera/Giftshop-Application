import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/homepage/homepage_screen.dart';
import 'package:lezemed_mobile_app/util_functions/routes.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final String type;
  final bool isFromPayment;
  final String paymentStatus;
  final ProductModel productModel;
  final BuildContext context;

  const AlertDialogWidget(
      {Key key,
      @required this.title,
      @required this.message,
      @required this.type,
      @required this.context,
      this.isFromPayment,
      this.productModel,
      this.paymentStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isFromPayment
        ? WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: dialogContent(
                title: title,
                message: message,
                type: type,
                context: context,
                model: productModel,
                isFromPayment: isFromPayment,
              ),
            ),
          )
        : Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: dialogContent(
                title: title,
                message: message,
                type: type,
                context: context,
                model: productModel,
                isFromPayment: isFromPayment,
                paymentStatus: paymentStatus),
          );
  }
}

Widget dialogContent({
  BuildContext context,
  ProductModel model,
  bool isFromPayment,
  String paymentStatus,
  @required title,
  @required message,
  @required type,
}) {
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            type == "WARNING"
                ? Image.asset('assets/images/warning-animation.gif')
                : Image.asset('assets/images/success-animation.gif'),
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(24.0)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                message,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(24.0)),
            Align(
                alignment: Alignment.bottomRight,
                child: isFromPayment && type != "WARNING"
                    ? TextButton(
                        onPressed: () async {
                          await model.deleteAllCartList();
                          await model.deleteAllPriceList();
                          Routes().pushReplacementNavigation(
                              context, HomePageScreen());
                        },
                        child: Text('Ok'),
                      )
                    : TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Ok'),
                      ))
          ],
        ),
      ),
    ],
  );
}
