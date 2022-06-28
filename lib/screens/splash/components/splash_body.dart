import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/screens/splash/widgets/splash_bottom_text.dart';
import 'package:lezemed_mobile_app/screens/splash/widgets/splash_logo.dart';

class SplashBody extends StatefulWidget {
  // SplashBody({Key? key}) : super(key: key);

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            gradient: kPrimaryFromTopLeftToBottomRightGradientColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Widget - Splash Logo
              SplashLogo(),
              // Widget - Splash Bottom Text
              SplashBottomText(),
            ],
          )),
    );
  }
}
