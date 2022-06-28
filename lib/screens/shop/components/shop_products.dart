import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/shop/components/shop_product_grid.dart';

class ShopProduct extends StatefulWidget {
  final String categoryId;
  final bool isSearchActivated;
  final String searchTerm;
  final String inheritedCategoryId;
  final ProductModel model;

  ShopProduct({
    Key key,
    @required this.categoryId,
    @required this.model,
    @required this.isSearchActivated,
    @required this.searchTerm,
    @required this.inheritedCategoryId,
  }) : super(key: key);

  @override
  _ShopProductState createState() => _ShopProductState();
}

class _ShopProductState extends State<ShopProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.inheritedCategoryId != null
          ? SizeConfig.screenHeight / 1.6
          : SizeConfig.screenHeight / 1.9,
      // width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      padding: EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ShopProductGrid(
              categoryId: widget.categoryId,
              model: widget.model,
              isSearchActivated: widget.isSearchActivated,
              searchTerm: widget.searchTerm),
        ],
      ),
    );
  }
}
