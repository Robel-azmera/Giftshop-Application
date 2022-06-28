import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/global_widgets/network_sensitivity.dart';
import 'package:lezemed_mobile_app/scoped_model/connected_model.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/base/base_view.dart';
import 'package:lezemed_mobile_app/screens/shop/components/shop_filter.dart';
import 'package:lezemed_mobile_app/screens/shop/components/shop_products.dart';
import 'package:lezemed_mobile_app/screens/shop/components/shop_search.dart';

class ShopBody extends StatefulWidget {
  final String inheritedCategoryId;
  ShopBody({Key key, this.inheritedCategoryId}) : super(key: key);

  @override
  _ShopBodyState createState() => _ShopBodyState();
}

class _ShopBodyState extends State<ShopBody> {
  //  Variables
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Map<String, dynamic> _searchInputData = {'searchTerm': null};
  bool isSearchActivated = false;
  String categoryId, searchTerm;

  @override
  void initState() {
    widget.inheritedCategoryId != null
        ? setState(() => categoryId = widget.inheritedCategoryId)
        : null;
    super.initState();
  }

  void printSmt() {
    _searchInputData['searchTerm'] != ""
        ? setState(() => isSearchActivated = true)
        : setState(() => isSearchActivated = false);
  }

  Future<void> onRefreshDetected(ProductModel model) {
    return model.getAllProductCategoriesWithFilter(categoryId, 1);
  }

  set string(String value) => setState(() => categoryId = value);
  set search(String value) =>
      setState(() => _searchInputData['searchTerm'] = value);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductModel>(
      builder: (context, child, model) => Expanded(
        flex: 1,
        child: NetworkSensitivity(
          child: ListView(
            children: [
              ShopSearch(
                  formKey: formKey,
                  isSearchActivated: isSearchActivated,
                  setSearch: (val) => setState(() => searchTerm = val),
                  searchTerm: searchTerm,
                  onChange: printSmt),
              ShopFilter(
                  callback: (val) => setState(() => categoryId = val),
                  model: model,
                  categoryId: categoryId),
              ShopProduct(
                categoryId: categoryId,
                isSearchActivated: isSearchActivated,
                searchTerm: searchTerm,
                model: model,
                inheritedCategoryId: widget.inheritedCategoryId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef void StringCallback(String val);
