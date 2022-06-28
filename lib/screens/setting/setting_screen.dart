import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/global_widgets/custom_app_bar.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/scoped_model/utility_model.dart';
import 'package:lezemed_mobile_app/screens/base/base_view.dart';
import 'package:lezemed_mobile_app/screens/setting/components/setting_content.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Setting extends StatelessWidget {
  const Setting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<UtilityModel>(
      builder: (context, child, model) => SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                ValueListenableBuilder<Box<Cart>>(
                    valueListenable: CartController.getCart().listenable(),
                    builder: (context, box, _) {
                      final cart = box.values.toList().cast<Cart>();
                      return customAppBar(
                        title: AppStrings.setting,
                        isRightIconVisible: true,
                        isLeftIconBack: false,
                        context: context,
                        amount: cart.length,
                      );
                    }),
                SettingContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
