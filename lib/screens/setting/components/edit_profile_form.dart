import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/util_functions/util.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Variable
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Map<String, dynamic> _updatedUserProfile = {
    'userProfile': null,
    'userFullName': null,
    'userEmail': null,
    'userPhoneNumber': null,
    'userPassword': null
  };
  bool _isLoading = false, checkCurrentPassword = true;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // Function for getting current user detail will be put here
  Future getCurrentUserDetail() async {}

  // Function for form submission will be put here
  void _submitUserUpdateRequest() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      // The rest is operation

      FocusScope.of(context).requestFocus(new FocusNode());
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: kSecondaryColor),
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildNameTextField(),
                SizedBox(height: 10.0),
                _buildEmailTextField(),
                SizedBox(height: 10.0),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        filled: true,
        fillColor: kBackgroundColor,
        labelText: AppStrings.fullName,
      ),
      textCapitalization: TextCapitalization.words,
      controller: nameController,
      validator: (String value) {
        if (!Util().validateNotEmpty(value)) return AppStrings.requiredMessage;
        if (!Util().validateName(value)) return AppStrings.invalidFormatMessage;
        return null;
      },
      onSaved: (value) {
        _updatedUserProfile['userFullName'] = value;
      },
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        labelText: AppStrings.email,
        filled: true,
        fillColor: kBackgroundColor,
      ),
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      validator: (String value) {
        if (!Util().validateNotEmpty(value)) return AppStrings.requiredMessage;
        if (!Util().validateEmail(value))
          return AppStrings.invalidFormatMessage;
        return null;
      },
      onSaved: (value) {
        _updatedUserProfile['userEmail'] = value;
      },
    );
  }

  // Widget _buildPasswordTextField(MainModel model) {
  //   return model.isProfileEditing == true
  //       ? TextFormField(
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //                 borderSide: BorderSide(width: 0, style: BorderStyle.none)),
  //             labelText: 'Your Password',
  //             errorText: checkCurrentPassword
  //                 ? null
  //                 : 'Please double check your password',
  //             filled: true,
  //             fillColor: kBackgroundColor,
  //           ),
  //           obscureText: true,
  //           validator: (String value) {
  //             if (!Util().validateNotEmpty(value))
  //               return "Password is required";
  //             return null;
  //           },
  //           onSaved: (value) {
  //             _updatedUserProfile['userPassword'] = value;
  //           },
  //         )
  //       : Container();
  // }

  Widget _buildSubmitButton() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: kPrimaryFromLefttoRightGradientColor,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: TextButton(
        onPressed: () {
          _submitUserUpdateRequest();
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          padding: EdgeInsets.symmetric(vertical: 15.0),
          primary: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              AntDesign.user,
              color: kWhitishBackgrounColor,
              size: 20.0,
            ),
            SizedBox(width: 20.0),
            Text(
              AppStrings.updateProfile,
              style: TextStyle(fontSize: 19.0, color: kWhitishBackgrounColor),
            )
          ],
        ),
      ),
    );
  }
}
