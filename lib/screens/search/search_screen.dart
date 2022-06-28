import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/screens/search/components/searchpage_body.dart';

class SearchPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SearchPageScreenBody(),
    );
  }
}
