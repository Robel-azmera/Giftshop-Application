import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/models/products.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/product_detail/components/product_detail_body.dart';

class ProductDetailPageScreen extends StatefulWidget {
  const ProductDetailPageScreen({
    Key key,
    @required this.productData,
    @required this.model,
    this.isfavourite,
  }) : super(key: key);
  final Product productData;
  final ProductModel model;
  final bool isfavourite;
  @override
  _ProductDetailPageScreenState createState() =>
      _ProductDetailPageScreenState();
}

class _ProductDetailPageScreenState extends State<ProductDetailPageScreen> {
  @override
  void dispose() {
    Hive.box('favourite').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: ProductDetailScreenBody(
        productData: widget.productData,
        model: widget.model,
      ),
    );
  }
}
