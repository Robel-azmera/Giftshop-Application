import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/scoped_model/connected_model.dart';
import 'package:lezemed_mobile_app/screens/setting/components/edit_profile_form.dart';
import 'package:lezemed_mobile_app/util_functions/util.dart';

class SettingOptions extends StatefulWidget {
  final ConnectedModel model;
  const SettingOptions({Key key, this.model}) : super(key: key);

  @override
  _SettingOptionsState createState() => _SettingOptionsState();
}

class _SettingOptionsState extends State<SettingOptions> {
  @override
  Widget build(BuildContext context) {
    // print(widget.model.isDarkModeEnabled);
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          // settingOptionBuilder(
          //     context: context,
          //     icon: Icon(Feather.user, size: 26.0),
          //     title: Text(AppStrings.editProfile),
          //     isTrailingSwitch: false,
          //     urlIndex: 0),
          // settingOptionBuilder(
          //     context: context,
          //     icon: Icon(Feather.lock, size: 26.0),
          //     title: Text(AppStrings.changePassword),
          //     isTrailingSwitch: false,
          //     urlIndex: 1),
          // settingOptionBuilder(
          //     context: context,
          //     icon: Icon(Feather.moon, size: 26.0),
          //     title: Text(AppStrings.darkMode),
          //     isTrailingSwitch: true,
          //     urlIndex: 2),
          settingOptionBuilder(
              context: context,
              icon: Icon(FontAwesome.exclamation, size: 26.0),
              title: Text(AppStrings.about),
              isTrailingSwitch: false,
              urlIndex: 3),
          settingOptionBuilder(
              context: context,
              icon: Icon(FontAwesome.question, size: 26.0),
              title: Text(AppStrings.helpAndSupport),
              isTrailingSwitch: false,
              urlIndex: 4),
        ],
      ),
    );
  }

  Widget settingOptionBuilder({
    @required context,
    @required icon,
    @required title,
    trailing,
    @required isTrailingSwitch,
    @required urlIndex,
  }) {
    return GestureDetector(
      onTap: () => urlIndex == 2 ? {} : actionDispacther(urlIndex, context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
          color: kWhitishBackgrounColor,
        ),
        child: ListTile(
          leading: icon,
          title: title,
          trailing: isTrailingSwitch
              ? Switch(
                  value: widget.model.isDarkModeEnabled,
                  onChanged: (value) {
                    widget.model.switchDarkMode(value);
                  },
                  activeColor: kBackgroundColor,
                  activeTrackColor: kPrimaryColor,
                  inactiveThumbColor: kPrimaryColor,
                  inactiveTrackColor: kBackgroundColor,
                )
              : GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.arrow_forward_ios),
                ),
        ),
      ),
    );
  }
}

void actionDispacther(int index, BuildContext context) async {
  switch (index) {
    case 0:
    case 1:
      _buildEditProfileBottomSheet(context);
      break;
    case 3:
    case 4:
      await Util().launchInWebViewOrVC("https://lezemed.com/contact-page/");
      break;
  }
}

void _buildEditProfileBottomSheet(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.0),
              Container(
                width: getProportionateScreenWidth(50.0),
                height: getProportionateScreenHeight(2.0),
                color: kPrimaryColor,
              ),
              EditProfile(),
            ],
          ),
        );
      });
}
