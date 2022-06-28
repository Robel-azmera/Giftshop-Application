import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/controller/favourite_controller.dart';
import 'package:lezemed_mobile_app/controller/price_info_controller.dart';
import 'package:lezemed_mobile_app/enums/view_state.dart';
import 'package:lezemed_mobile_app/global_widgets/check_busy_state.dart';
import 'package:lezemed_mobile_app/global_widgets/spinners.dart';
import 'package:lezemed_mobile_app/models/favourite.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';
import 'package:lezemed_mobile_app/models/products.dart';
import 'package:lezemed_mobile_app/models/variation.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:html/parser.dart';
import 'package:lezemed_mobile_app/screens/product_detail/widgets/review_builder.dart';
import 'package:lezemed_mobile_app/util_functions/util.dart';

class SpecificProductPageBuilder extends StatefulWidget {
  final List<Images> image;
  final ProductModel model;
  final Product product;

  const SpecificProductPageBuilder({
    Key key,
    this.image,
    @required this.model,
    @required this.product,
  }) : super(key: key);

  @override
  _SpecificProductPageBuilderState createState() =>
      _SpecificProductPageBuilderState();
}

class _SpecificProductPageBuilderState
    extends State<SpecificProductPageBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(35.0)),
            child: Container(
              margin: EdgeInsets.only(left: getProportionateScreenWidth(30.0)),
              child: Image.network(
                widget.image[0].src,
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: getProportionateScreenHeight(240),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenWidth(37),
          ),
        ],
      ),
    );
  }
}

class BottomContainer extends StatefulWidget {
  BottomContainer({
    Key key,
    @required this.data,
    @required this.model,
    @required this.amount,
    this.variants,
  }) : super(key: key);

  final Product data;
  final ProductModel model;
  final List<Variation> variants;

  int amount;

  @override
  _BottomContainerState createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  bool _isfavourite;

  String description = '';
  bool _isCartVisible = false;
  int _activeTab;
  String displayPrice = '';

  bool hasdata = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Favourite>>(
        valueListenable: FavouriteController.getfavourite().listenable(),
        builder: (context, box, _) {
          final fav = box.values.toList().cast<Favourite>();
          _isfavourite = false;
          for (var i in fav) {
            if (widget.data.id == i.id) {
              _isfavourite = i.isFavourite;
            }
          }

          return ValueListenableBuilder<Box<PriceInfo>>(
            valueListenable: PriceInfoController.getPrice().listenable(),
            builder: (context, box, _) {
              final priceInfo = box.values.toList().cast<PriceInfo>();

              return Container(
                padding: EdgeInsets.all(37.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(65.0),
                      topRight: Radius.circular(65.0)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(250),
                          child: Text(
                            widget.data.name != null
                                ? widget.data.name
                                : 'No Name',
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: _isfavourite
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.favorite_outline,
                                  size: 30,
                                ),
                          onPressed: () {
                            bool addToWishlist =
                                widget.model.addWishlist(widget.data);
                            /**
                             * if it is sure that the product is added to wishlist, we then add the favourite 
                             * box also. and make the variable boolean 'true'
                            */
                            if (addToWishlist == true) {
                              bool addToFav = widget.model
                                  .addFavourite(widget.data.id, true);
                            }
                            // addToWishlist
                            addToWishlist
                                ? Fluttertoast.showToast(
                                    msg: "Product added to wishlist",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey[200],
                                    textColor: kPrimaryColor,
                                    fontSize: 16.0)
                                : Fluttertoast.showToast(
                                    msg: "Product already in the wishlist",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey[200],
                                    textColor: kPrimaryColor,
                                    fontSize: 16.0);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15.0),
                    ),
                    Text(
                      widget.data.short_description.length >= 1
                          ? Util()
                              .parseHtmlString(widget.data.short_description)
                          : 'No Description',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    widget.model.currentState == ViewState.Retrived &&
                            widget.variants.length > 0
                        ? CheckBusyState(
                            state: widget.model.currentState,
                            isShimmer: true,
                            child: Column(
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(100),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.variants.length,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        if (widget.variants.length <= 0)
                                          return SizedBox.shrink();
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      20.0),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  widget.data.price = widget
                                                      .variants[index].price;
                                                  widget.data.id =
                                                      widget.variants[index].id;
                                                  for (var i in priceInfo) {
                                                    if (i.id ==
                                                        widget.data.id) {
                                                      i.price = int.parse(widget
                                                          .variants[index]
                                                          .price);
                                                      widget.model
                                                          .updatePrice(i);
                                                    }
                                                  }
                                                  description = widget
                                                      .variants[index]
                                                      .description;
                                                  _isCartVisible = true;
                                                  _activeTab = index;
                                                  displayPrice =
                                                      '\$ ${int.parse(widget.data.price) * widget.amount}';
                                                });
                                              },
                                              child: _activeTab == index
                                                  ? Container(
                                                      margin:
                                                          EdgeInsets.all(9.0),
                                                      padding:
                                                          EdgeInsets.all(13.0),
                                                      decoration: BoxDecoration(
                                                        color: kSecondaryColor,
                                                        border: Border.all(
                                                            width: 1.0,
                                                            color:
                                                                kSecondaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Text(
                                                        widget.variants[index]
                                                            .price,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      margin:
                                                          EdgeInsets.all(9.0),
                                                      padding:
                                                          EdgeInsets.all(13.0),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1.0,
                                                            color:
                                                                kSecondaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Text(widget
                                                          .variants[index]
                                                          .price),
                                                    ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      20.0),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                                Container(
                                  child: Text(
                                      ' ${Util().parseHtmlString(description)}'),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(90.0),
                          child: widget.data.id == 7788
                              ? Text(
                                  '$displayPrice',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                )
                              : Text(
                                  '\$ ${int.parse(widget.data.price) * widget.amount}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(50.0),
                        ),
                        widget.data.id != 7788
                            ? Container(
                                width: getProportionateScreenWidth(120.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove_outlined),
                                      onPressed: () {
                                        setState(() {
                                          if (widget.amount > 1) {
                                            widget.amount = widget.amount - 1;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      '${widget.amount}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_outlined),
                                      onPressed: () {
                                        setState(() {
                                          widget.amount = widget.amount + 1;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        Flexible(
                          flex: 2,
                          child: Container(
                            height: getProportionateScreenHeight(60.0),
                            width: getProportionateScreenWidth(60.0),
                            child: FittedBox(
                              child: widget.data.id == 7788
                                  ? _isCartVisible
                                      ? FloatingActionButton(
                                          heroTag: 'addtocart',
                                          child: Container(
                                            width: getProportionateScreenWidth(
                                                60.0),
                                            height:
                                                getProportionateScreenHeight(
                                                    60.0),
                                            child: Icon(
                                              Icons.add_shopping_cart,
                                              size: 27,
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient:
                                                    kPrimaryFromTopToBottomGradientColor),
                                          ),
                                          onPressed: () {
                                            bool addToCartList = widget.model
                                                .addCartlist(widget.data);

                                            addToCartList
                                                ? Fluttertoast.showToast(
                                                    msg:
                                                        "Product added to cart",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    textColor: kPrimaryColor,
                                                    fontSize: 16.0)
                                                : Fluttertoast.showToast(
                                                    msg:
                                                        "Product already in the cart",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    textColor: kPrimaryColor,
                                                    fontSize: 16.0);
                                            if (addToCartList == true) {
                                              print(displayPrice);
                                              widget.model.addPrice(
                                                widget.data.id,
                                                widget.amount,
                                                int.parse(widget.data.price),
                                              );
                                            }
                                          },
                                        )
                                      : FloatingActionButton(
                                          heroTag: 'addtocart',
                                          child: Container(
                                            width: getProportionateScreenWidth(
                                                60.0),
                                            height:
                                                getProportionateScreenHeight(
                                                    60.0),
                                            child: Icon(
                                              Icons.add_shopping_cart,
                                              size: 27,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          onPressed: () {},
                                        )
                                  : FloatingActionButton(
                                      heroTag: 'addtocart',
                                      child: Container(
                                        width:
                                            getProportionateScreenWidth(60.0),
                                        height:
                                            getProportionateScreenHeight(60.0),
                                        child: Icon(
                                          Icons.add_shopping_cart,
                                          size: 27,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient:
                                                kPrimaryFromTopToBottomGradientColor),
                                      ),
                                      onPressed: () {
                                        bool addToCartList = widget.model
                                            .addCartlist(widget.data);

                                        addToCartList
                                            ? Fluttertoast.showToast(
                                                msg: "Product added to cart",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                textColor: kPrimaryColor,
                                                fontSize: 16.0)
                                            : Fluttertoast.showToast(
                                                msg:
                                                    "Product already in the cart",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                textColor: kPrimaryColor,
                                                fontSize: 16.0);
                                        if (addToCartList == true) {
                                          widget.model.addPrice(
                                              widget.data.id,
                                              widget.amount,
                                              int.parse(widget.data.price));
                                        }
                                      },
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(8.0),
                    ),
                    Divider(),
                    ReviewBuilder(data: widget.data, model: widget.model),
                    SizedBox(
                      height: getProportionateScreenHeight(8.0),
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          );
        });
  }
}
