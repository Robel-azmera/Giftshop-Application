import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/global_widgets/spinners.dart';
import 'package:lezemed_mobile_app/models/products.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/product_detail/product_detail.dart';
import 'package:lezemed_mobile_app/screens/search/components/searchpage_body.dart';
import 'package:lezemed_mobile_app/util_functions/routes.dart';

//Builds the search box
Widget searchBoxBuilder(
    {GlobalKey<FormState> formKey,
    bool isSearchActivated,
    StringCallback setSearch,
    Function onChange}) {
  return Container(
    height: getProportionateScreenHeight(55),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Form(
        key: formKey,
        child: Material(
          elevation: 1.0,
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          child: new TextFormField(
              autocorrect: true,
              cursorColor: kSecondaryColor,
              decoration: new InputDecoration(
                icon: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(25),
                    vertical: getProportionateScreenHeight(10),
                  ),
                  child: Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
                hintText: AppStrings.search,
                hintStyle: TextStyle(fontSize: 15),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(18.0),
                ),
              ),
              onChanged: (value) {
                setSearch(value);
                onChange();
              }),
        ),
      ),
    ),
  );
}

//Scrolling Search Page Builder - List View of items
Widget searchPageResultsBuilder(
    {ProductModel model,
    bool isSearchActivated,
    String searchTerm,
    BuildContext buildContext}) {
  return Expanded(
    flex: 1,
    child: isSearchActivated
        ? FutureBuilder(
            future: model.getSearchProduct(searchTerm),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Spinners(color: kSecondaryColor, size: 26.0));
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
                    return Center(child: Text("No Product Found"));
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return snapshot.data[index].status == "publish" &&
                                snapshot.data[index].catalog_visibility ==
                                    "visible"
                            ? scrollingSearchItemBuilder(
                                imageLocation:
                                    snapshot.data[index].images[0].src,
                                title: snapshot.data[index].name,
                                price: snapshot.data[index].price.toString(),
                                model: model,
                                context: context,
                                data: snapshot.data[index],
                              )
                            : SizedBox.shrink();
                      });
              }
            })
        : Container(
            child: Center(
              child: Text(
                "Search products by name",
              ),
            ),
          ),
  );
}

//return items to be displayed in the search scroll list
Widget scrollingSearchItemBuilder(
    {String title,
    String price,
    int amount,
    String imageLocation,
    ProductModel model,
    BuildContext context,
    Product data}) {
  return Row(
    children: [
      Expanded(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Routes().navigation(
                    context,
                    ProductDetailPageScreen(
                      model: model,
                      productData: data,
                    ));
              },
              leading: Image.network(
                imageLocation,
                width: getProportionateScreenWidth(100),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: getProportionateScreenWidth(175),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ $price',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingBar(
                      initialRating: 3,
                      itemSize: 15,
                      glow: false,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      unratedColor: kBackgroundColor,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                        ),
                        half: Icon(
                          Icons.star_half,
                          color: Colors.yellow[700],
                        ),
                        empty: Icon(
                          Icons.star_border_outlined,
                          color: Colors.yellow[700],
                        ),
                      ),
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
              ), //////////List Tile On Tap  implementation here
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Divider(),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
          ],
        ),
      ),
      Divider(),
    ],
  );
}
