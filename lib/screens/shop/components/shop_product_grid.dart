import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/global_widgets/no_data.dart';
import 'package:lezemed_mobile_app/global_widgets/spinners.dart';
import 'package:lezemed_mobile_app/models/products.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/product_detail/product_detail.dart';
import 'package:lezemed_mobile_app/util_functions/routes.dart';

class ShopProductGrid extends StatefulWidget {
  final String categoryId;
  final bool isSearchActivated;
  final String searchTerm;
  final ProductModel model;

  ShopProductGrid({
    Key key,
    @required this.categoryId,
    @required this.model,
    @required this.isSearchActivated,
    @required this.searchTerm,
  }) : super(key: key);

  @override
  _ShopProductGridState createState() => _ShopProductGridState();
}

class _ShopProductGridState extends State<ShopProductGrid> {
  // Variables
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    Future _getProductWithCategory = widget.model
        .getAllProductCategoriesWithFilter(widget.categoryId, _page);

    return Expanded(
      child: FutureBuilder(
          initialData: [],
          future: widget.isSearchActivated && widget.searchTerm != ""
              ? widget.model.getSearchProduct(widget.searchTerm)
              : _getProductWithCategory,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Spinners(
                        color: kSecondaryColor,
                        size: getProportionateScreenWidth(30.0)));
                break;
              case ConnectionState.active:
              case ConnectionState.done:
              default:
                if (snapshot.hasError)
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Error Found: " + snapshot.error.toString()),
                  ));
                if (snapshot.data.length <= 0)
                  return NoDataIndicator(
                      message: AppStrings.noProductMessage, type: "NO_DATA");
                ;

                return ListView(
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 8.0,
                      spacing: 8.0,
                      children:
                          snapshot.data.asMap().entries.map<Widget>((products) {
                        if (products.value.status == "publish" &&
                            products.value.catalog_visibility == "visible") {
                          return productList(
                            image: products.value.images,
                            title: products.value.name,
                            price: products.value.price,
                            data: products.value,
                            model: widget.model,
                            context: context,
                          );
                        } else
                          return SizedBox.shrink();
                      }).toList(),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20.0)),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _page != 1
                            ? TextButton(
                                onPressed: () {
                                  setState(() {
                                    --_page;
                                  });
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.navigate_before, size: 40.0),
                                    Text("Prev",
                                        style: TextStyle(fontSize: 18.0)),
                                  ],
                                ))
                            : SizedBox.shrink(),
                        // Text("Load More"),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                ++_page;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Next", style: TextStyle(fontSize: 18.0)),
                                Icon(Icons.navigate_next, size: 40.0)
                              ],
                            )),
                      ],
                    ),
                  ],
                );
              // return GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: MediaQuery.of(context).orientation ==
              //               Orientation.landscape
              //           ? 3
              //           : 2,
              //       crossAxisSpacing: 8,
              //       mainAxisSpacing: 38,
              //     ),
              //     itemCount: snapshot.data.length,
              //     itemBuilder: (context, index) {
              //       return productList(
              //         image: snapshot.data[index].images,
              //         title: snapshot.data[index].name,
              //         price: snapshot.data[index].price,
              //         data: snapshot.data[index],
              //         model: widget.model,
              //       );
              //     });

            }
          }),
    );
  }
}

Widget productList({
  List<Images> image,
  String title,
  String price,
  BuildContext context,
  Product data,
  ProductModel model,
}) {
  return GestureDetector(
    onTap: () {
      Routes().navigation(
          context,
          ProductDetailPageScreen(
            model: model,
            productData: data,
          ));
    },
    child: Container(
      height: getProportionateScreenHeight(200),
      width: getProportionateScreenWidth(170),
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: image.length <= 0
                  ? Image.asset('assets/images/no_image.jpeg')
                  : Image.network(
                      image[0].src,
                      alignment: Alignment.centerLeft,
                      width: getProportionateScreenWidth(130),
                      height: getProportionateScreenHeight(120),
                    ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                height: getProportionateScreenHeight(
                    90), //Limit the container to limit the text title not to make overflows
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 17,
                    color: kSecondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  data.id != 7788
                      ? Text(
                          "\$" + price,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      : SizedBox.shrink(),
                  Container(
                    height: getProportionateScreenHeight(45.0),
                    width: 45.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        child: Container(
                          width: 60,
                          height: 60,
                          child: Icon(
                            AntDesign.hearto,
                            size: 27,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: kPrimaryFromTopToBottomGradientColor,
                          ),
                        ),
                        onPressed: () {
                          bool addToWishlist = model.addWishlist(data);
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
                          //if product added to wishlist rhis state updates the heart icon
                          if (addToWishlist == true) {
                            bool isfavourite =
                                model.addFavourite(data.id, true);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
