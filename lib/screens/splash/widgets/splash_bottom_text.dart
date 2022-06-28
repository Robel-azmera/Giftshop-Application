import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';

class SplashBottomText extends StatelessWidget {
  // const SplashBottomText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Powered by", style: TextStyle(color: Colors.white)),
          SizedBox(width: getProportionateScreenWidth(5.0)),
          Text(
            "ZERGAW",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
