import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/global_widgets/custom_app_bar.dart';
import 'package:lezemed_mobile_app/models/products.dart';
import 'package:lezemed_mobile_app/models/variation.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/product_detail/components/product_detail_components.dart';

class ProductDetailScreenBody extends StatefulWidget {
  const ProductDetailScreenBody({
    Key key,
    @required this.productData,
    @required this.model,
  }) : super(key: key);

  final Product productData;
  final ProductModel model;

  @override
  _ProductDetailScreenBodyState createState() =>
      _ProductDetailScreenBodyState();
}

class _ProductDetailScreenBodyState extends State<ProductDetailScreenBody> {
  List<Variation> variants = [];
  bool isVariantsFetched = false;

  @override
  void initState() {
    super.initState();
    getProductVariation();
  }

  Future getProductVariation() async {
    variants = await widget.model
        .getProductVariation(productId: widget.productData.id.toString());
    variants.length > 0
        ? setState(() => isVariantsFetched = true)
        : setState(() => isVariantsFetched = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Container(
          child: Column(
            children: [
              customAppBar(
                title: '',
                isRightIconVisible: false,
                isLeftIconBack: true,
                context: context,
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    SpecificProductPageBuilder(
                      image: widget.productData.images,
                      model: widget.model,
                    ),
                    BottomContainer(
                        data: widget.productData,
                        model: widget.model,
                        amount: 1,
                        variants: variants),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// typedef void MyStringCallback(String key);
// typedef void IntegerCallback(int val);
