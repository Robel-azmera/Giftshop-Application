import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/screens/setting/widgets/user_info.dart';
import 'package:lezemed_mobile_app/screens/setting/widgets/user_profile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: getProportionateScreenHeight(250.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserProfileWidget(),
          SizedBox(height: getProportionateScreenHeight(20)),
          UserInformation(),
        ],
      ),
    );
  }
}
