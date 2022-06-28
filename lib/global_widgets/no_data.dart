import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lezemed_mobile_app/config/size.dart';

class NoDataIndicator extends StatelessWidget {
  final String message;
  final String type; // For search and no data
  const NoDataIndicator({Key key, @required this.message, @required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: type == "NO_DATA"
                ? SvgPicture.asset(
                    "assets/images/no_data.svg",
                    width: getProportionateScreenWidth(
                        SizeConfig.screenWidth / 1.7),
                  )
                : SvgPicture.asset(
                    "assets/images/no_file.svg",
                    width: getProportionateScreenWidth(
                        SizeConfig.screenWidth / 1.7),
                  ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(40.0),
          ),
          Text(message, style: TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}
