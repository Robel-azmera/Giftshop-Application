import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    Key key,
    @required this.image,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        Image.asset(
          image,
          width: getProportionateScreenWidth(340),
          height: getProportionateScreenHeight(285),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            color: kSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(22),
        ),
        Container(
          width: getProportionateScreenWidth(250),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(14),
            ),
          ),
        ),
      ],
    );
  }
}
