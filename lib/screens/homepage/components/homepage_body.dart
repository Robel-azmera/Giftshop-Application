import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/global_widgets/custom_app_bar.dart';
import 'package:lezemed_mobile_app/global_widgets/refresh_widget.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/base/base_view.dart';
import 'package:lezemed_mobile_app/screens/homepage/components/homepage_content.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePageScreenBody extends StatefulWidget {
  const HomePageScreenBody({Key key}) : super(key: key);

  @override
  _HomePageScreenBodyState createState() => _HomePageScreenBodyState();
}

class _HomePageScreenBodyState extends State<HomePageScreenBody> {
  // On Pull to Refresh
  Future onPullToRefresh(ProductModel model) async {
    await model.getAllProductCategories();
    await model.getNewArrivalProduct();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductModel>(
      builder: (context, child, model) => SafeArea(
        child: Scaffold(
          body: GestureDetector(
            child: RefreshWidget(
              onRefresh: () => onPullToRefresh(model),
              child: Container(
                child: Column(
                  children: [
                    ValueListenableBuilder<Box<Cart>>(
                        valueListenable: CartController.getCart().listenable(),
                        builder: (context, box, _) {
                          final cart = box.values.toList().cast<Cart>();

                          return customAppBar(
                              title: AppStrings.fullAppName,
                              isRightIconVisible: true,
                              isLeftIconBack: false,
                              context: context,
                              amount: cart.length);
                        }),
                    // customHomePageAppBar(), -- a custom method for homepage custom app bar
                    // Use the below function to create a new custom app bar

                    ScrollingHomeBuilder(model: model),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
