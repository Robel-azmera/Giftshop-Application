import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/global_widgets/network_sensitivity.dart';
import 'package:lezemed_mobile_app/scoped_model/connected_model.dart';
import 'package:lezemed_mobile_app/screens/base/base_view.dart';
import 'package:lezemed_mobile_app/screens/setting/components/setting_options.dart';
import 'package:lezemed_mobile_app/screens/setting/components/setting_userprofile.dart';

class SettingContent extends StatelessWidget {
  const SettingContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ConnectedModel>(
      builder: (context, child, model) => Expanded(
        flex: 1,
        child: NetworkSensitivity(
          child: ListView(
            children: [
              SizedBox(height: getProportionateScreenHeight(30)),
              UserProfile(),
              SettingOptions(model: model),
            ],
          ),
        ),
      ),
    );
  }
}
