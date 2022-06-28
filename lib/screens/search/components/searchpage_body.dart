import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/controller/cart_controller.dart';
import 'package:lezemed_mobile_app/global_widgets/custom_app_bar.dart';
import 'package:lezemed_mobile_app/global_widgets/network_sensitivity.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/base/base_view.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/screens/search/components/searchpage_contents.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchPageScreenBody extends StatefulWidget {
  const SearchPageScreenBody({Key key}) : super(key: key);

  @override
  _SearchPageScreenBodyState createState() => _SearchPageScreenBodyState();
}

class _SearchPageScreenBodyState extends State<SearchPageScreenBody> {
  // Variables
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Map<String, dynamic> _searchInputData = {'searchTerm': null};
  bool isSearchActivated = false;
  String searchTerm;

  set string(String value) =>
      setState(() => _searchInputData['searchTerm'] = value);

  void changeState() {
    _searchInputData['searchTerm'] != ""
        ? setState(() => isSearchActivated = true)
        : setState(() => isSearchActivated = false);
    print(isSearchActivated);
  }

  @override
  Widget build(BuildContext buildContext) {
    return BaseView<ProductModel>(
      builder: (context, child, model) => SafeArea(
        child: NetworkSensitivity(
          child: Container(
            child: Column(
              children: [
                ValueListenableBuilder<Box<Cart>>(
                    valueListenable: CartController.getCart().listenable(),
                    builder: (context, box, _) {
                      final cart = box.values.toList().cast<Cart>();
                      return customAppBar(
                          title: AppStrings.search,
                          isRightIconVisible: true,
                          isLeftIconBack: true,
                          context: context,
                          amount: cart.length);
                    }),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                searchBoxBuilder(
                    formKey: formKey,
                    isSearchActivated: isSearchActivated,
                    setSearch: (val) =>
                        setState(() => _searchInputData['searchTerm'] = val),
                    onChange: changeState),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                searchPageResultsBuilder(
                  isSearchActivated: isSearchActivated,
                  model: model,
                  searchTerm: _searchInputData['searchTerm'],
                  buildContext: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef void StringCallback(String val);
