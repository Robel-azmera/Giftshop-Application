import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/global_widgets/alert_dialog.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextButton(
        onPressed: () {
          _buildSignInErrorMessageDialog(context);
        },
        child: Text(
          "Sign In",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
            fontSize: 20.0,
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          _buildSignInErrorMessageDialog(context);
        },
        child: Text(
          "Don't have an account ? \n Create Account",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: kPrimaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ]);
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
          isFromPayment: false,
        );
      });
}
