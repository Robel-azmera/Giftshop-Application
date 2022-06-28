import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/global_widgets/check_busy_state.dart';
import 'package:lezemed_mobile_app/models/categories.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/shop/components/shop_body.dart';

class ShopFilter extends StatefulWidget {
  final StringCallback callback;
  final String categoryId;
  final ProductModel model;

  ShopFilter(
      {Key key,
      @required this.callback,
      @required this.model,
      @required this.categoryId})
      : super(key: key);

  @override
  _ShopFilterState createState() => _ShopFilterState();
}

class _ShopFilterState extends State<ShopFilter> {
  bool isFilterActivated = false;
  int isTapActive;
  List<Category> allCategories = [];

  @override
  void initState() {
    super.initState();
    getCategory();
    isTapActive = widget.categoryId != null ? int.parse(widget.categoryId) : 0;
  }

  Future getCategory() async {
    allCategories = await widget.model.getAllProductCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(42),
      margin: EdgeInsets.only(top: 0.0, left: 20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() => isTapActive = 0);
              widget.callback("-1");
            },
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 19.0, vertical: 13.0),
              decoration: isTapActive == 0
                  ? BoxDecoration(
                      gradient: kPrimaryFromLefttoRightGradientColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    )
                  : BoxDecoration(
                      color: kWhitishBackgrounColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
              child: Text(
                AppStrings.allProduct,
                style: TextStyle(
                  color:
                      isTapActive == 0 ? kWhitishBackgrounColor : kPrimaryColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: CheckBusyState(
              state: widget.model.currentState,
              isShimmer: true,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: allCategories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isTapActive = allCategories[index].categoryID;
                        });
                        widget.callback(
                            allCategories[index].categoryID.toString());
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 19.0, vertical: 13.0),
                        decoration: isTapActive ==
                                allCategories[index].categoryID
                            ? BoxDecoration(
                                gradient: kPrimaryFromLefttoRightGradientColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              )
                            : BoxDecoration(
                                color: kWhitishBackgrounColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                        child: Text(
                          allCategories[index].categoryName,
                          style: TextStyle(
                            color:
                                isTapActive == allCategories[index].categoryID
                                    ? kWhitishBackgrounColor
                                    : kPrimaryColor,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
