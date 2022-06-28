import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/global_widgets/alert_dialog.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(100),
      height: getProportionateScreenHeight(100),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: kPrimaryColor.withOpacity(0.5)),
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: Container(
        width: getProportionateScreenWidth(90),
        height: getProportionateScreenHeight(90),
        decoration: BoxDecoration(
          gradient: kPrimaryFromTopLeftToBottomRightGradientColor,
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: IconButton(
          onPressed: () {
            _buildSignInErrorMessageDialog(context);
          },
          icon: Icon(AntDesign.poweroff, size: 40.0),
          color: kWhitishBackgrounColor,
        ),
      ),
    );
  }
}

_buildSignInErrorMessageDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(
            title: 'Account Warning',
            message: AppStrings.accountPrivilage,
            type: 'WARNING',
            context: context,
            isFromPayment: false);
      });
}
