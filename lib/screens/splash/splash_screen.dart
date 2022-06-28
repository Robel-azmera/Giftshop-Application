import 'package:flutter/material.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';

import 'components/splash_body.dart';

class SplashScreen extends StatelessWidget {
  // const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: SplashBody(),
      ),
    );
  }
}
