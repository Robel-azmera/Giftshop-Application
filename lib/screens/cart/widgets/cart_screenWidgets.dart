import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';

class CartScrollPage extends StatefulWidget {
  final String imageLocation;
  final String title;
  final Cart data;
  final int price;
  final int id;
  final ProductModel model;
  final PriceInfo singlePriceInfo;
  final List<PriceInfo> priceInfo;

  CartScrollPage({
    @required this.data,
    @required this.imageLocation,
    @required this.title,
    @required this.price,
    @required this.id,
    @required this.model,
    @required this.singlePriceInfo,
    @required this.priceInfo,
  });

  @override
  _CartScrollPageState createState() => _CartScrollPageState();
}

class _CartScrollPageState extends State<CartScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Routes().navigation(
            //   context,
            //   ProductDetailPageScreen(
            //     model: widget.model,
            //     // productData: product,
            //   ),
            // );
          },
          child: ListTile(
            leading: Container(
              width: getProportionateScreenWidth(100),
              child: Image.network(
                widget.imageLocation,
                width: getProportionateScreenWidth(100),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getProportionateScreenWidth(175),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: getProportionateScreenWidth(10),
                        bottom: getProportionateScreenHeight(20),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 13,
                        onPressed: () {
                          widget.model.deleteCartlist(widget.id);
                          widget.model.deletePrice(widget.id);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${widget.price * widget.singlePriceInfo.amount}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kSecondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: getProportionateScreenWidth(17),
                            height: getProportionateScreenWidth(17),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0, color: kTextColor),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: new FloatingActionButton(
                              elevation: 0.0,
                              heroTag: 'minus',
                              backgroundColor: kBackgroundColor,
                              child: Icon(
                                Icons.remove,
                                size: 15,
                                color: kPrimaryColor,
                              ),
                              onPressed: () {
                                if (widget.singlePriceInfo.amount > 1) {
                                  setState(() {
                                    widget.singlePriceInfo.amount =
                                        widget.singlePriceInfo.amount - 1;
                                  });
                                  bool updateMinus = widget.model
                                      .updatePrice(widget.singlePriceInfo);
                                  print(updateMinus);

                                  print(
                                      "amount ${widget.singlePriceInfo.amount}");

                                  print(
                                      "price ${widget.singlePriceInfo.amount * widget.price}");
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: getProportionateScreenWidth(15),
                            child: Text(
                              '${widget.singlePriceInfo.amount}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: getProportionateScreenWidth(17),
                            height: getProportionateScreenWidth(17),
                            child: new FloatingActionButton(
                              elevation: 0.0,
                              heroTag: 'plus',
                              backgroundColor: kTextColor,
                              child: Icon(
                                Icons.add,
                                size: 15,
                              ),
                              onPressed: () {
                                setState(() {
                                  widget.singlePriceInfo.amount =
                                      widget.singlePriceInfo.amount + 1;
                                });

                                bool updatePlus = widget.model
                                    .updatePrice(widget.singlePriceInfo);
                                print(updatePlus);

                                print(
                                    "amount ${widget.singlePriceInfo.amount}");
                                print(
                                    "price ${widget.singlePriceInfo.amount * widget.price}");
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {}, //////////List Tile On Tap  implementation here
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Divider(),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
      ],
    );
  }
}
