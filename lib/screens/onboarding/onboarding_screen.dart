import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/screens/onboarding/components/onboarding_body.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: OnBoardingScreenBody(),
    );
  }
}
