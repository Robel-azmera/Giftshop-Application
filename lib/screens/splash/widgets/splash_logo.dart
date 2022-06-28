import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/global_widgets/spinners.dart';

class SplashLogo extends StatelessWidget {
  // const SplashLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(SizeConfig.screenHeight / 1.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "assets/images/LezemedLogo.png",
              width: getProportionateScreenWidth(90),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(15.0)),
          Text(
            AppStrings.firstAppName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 9,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(1.0, 3.0),
                  blurRadius: 3.0,
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                )
              ],
            ),
          ),
          Text(
            AppStrings.secondAppName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20.0),
          ),
          Spinners(
              color: Color.fromRGBO(255, 255, 255, 1),
              size: getProportionateScreenWidth(30.0)),
        ],
      ),
    );
  }
}
