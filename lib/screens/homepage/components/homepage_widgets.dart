import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/global_widgets/check_busy_state.dart';
import 'package:lezemed_mobile_app/models/categories.dart' as Categories;
import 'package:lezemed_mobile_app/models/products.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/screens/product_detail/product_detail.dart';
import 'package:lezemed_mobile_app/screens/shop/shop_screen.dart';
import 'package:lezemed_mobile_app/util_functions/routes.dart';

//Builds the NewArrival part in the homepage screen
Widget newArrivalsListViewBuilder({
  ProductModel model,
  BuildContext context,
  List<Product> fetchedNewArrivalProducts,
}) {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.newArrival,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(23),
        ),
        Flexible(
          child: CheckBusyState(
            state: model.currentState,
            isShimmer: false,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: fetchedNewArrivalProducts.length,
              itemBuilder: (context, index) {
                return fetchedNewArrivalProducts[index].status == "publish" &&
                        fetchedNewArrivalProducts[index].catalog_visibility ==
                            "visible"
                    ? newArrivalItemBuilder(
                        image: fetchedNewArrivalProducts[index].images[0].src,
                        title: fetchedNewArrivalProducts[index].name,
                        price: fetchedNewArrivalProducts[index].price,
                        model: model,
                        context: context,
                        data: fetchedNewArrivalProducts[index])
                    : SizedBox.shrink();
              },
            ),
          ),
        ),
      ],
    ),
  );
}

//Builds One Item of the list view element in the new arrival category
Widget newArrivalItemBuilder(
    {String image,
    String title,
    String price,
    ProductModel model,
    BuildContext context,
    Product data}) {
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
      width: getProportionateScreenWidth(182),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Image.network(
              image,
              alignment: Alignment.centerLeft,
              width: getProportionateScreenWidth(130),
              height: getProportionateScreenHeight(120),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                  height: 45.0,
                  width: 45.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      child: Container(
                        width: 60,
                        height: 60,
                        child: Icon(
                          Icons.add_shopping_cart,
                          size: 27,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: kPrimaryFromTopToBottomGradientColor),
                      ),
                      onPressed: () {
                        bool addToCartList = model.addCartlist(data);

                        addToCartList
                            ? Fluttertoast.showToast(
                                msg: "Product added to cart",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey[200],
                                textColor: kPrimaryColor,
                                fontSize: 16.0)
                            : Fluttertoast.showToast(
                                msg: "Product already in the cart",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey[200],
                                textColor: kPrimaryColor,
                                fontSize: 16.0);
                        if (addToCartList == true) {
                          model.addPrice(data.id, 1, int.parse(data.price));
                        }
                      }, //////shopping cart on pressed
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

//Category item (card view) builder for the Category part
Widget categoryItemsListViewBuilder({
  List<Categories.Category> fetchedProductCategories,
  BuildContext context,
  ProductModel model,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.ourCategories,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
              ),
            ),
            IconButton(
              //refresh Icon Onpressed implementation here
              onPressed: () {
                model.getAllProductCategories();
              },
              icon: Icon(Icons.refresh),
              iconSize: 27,
              color: kSecondaryColor,
            )
          ],
        ),
      ),
      SizedBox(height: getProportionateScreenHeight(15.0)),
      Flexible(
        child: CheckBusyState(
          state: model.currentState,
          isShimmer: false,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: fetchedProductCategories.length,
              itemBuilder: (context, index) {
                return fetchedProductCategories[index].image != null
                    ? categoryElementBuilder(
                        image: fetchedProductCategories[index].image.url,
                        title: fetchedProductCategories[index].categoryName,
                        description:
                            fetchedProductCategories[index].categoryDescription,
                        categoryId: fetchedProductCategories[index]
                            .categoryID
                            .toString(),
                        context: context,
                      )
                    : SizedBox.shrink();
              }),
        ),
      ),
    ],
  );
}

//Builds One item of the Listview in the Category list
Widget categoryElementBuilder(
    {String image,
    String title,
    String description,
    String categoryId,
    BuildContext context}) {
  return Container(
    width: getProportionateScreenWidth(185),
    child: Column(
      children: [
        image == null
            ? SizedBox(
                width: getProportionateScreenWidth(130),
                height: getProportionateScreenHeight(90))
            : Image.network(
                image,
                width: getProportionateScreenWidth(130),
                height: getProportionateScreenHeight(90),
              ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        GestureDetector(
          onTap: () => Routes()
              .navigation(context, Shop(inheritedCategoryId: categoryId)),
          child: Text(
            AppStrings.viewMore,
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    ),
  );
}

//Builds the item in the slider
Widget sliderItemBuilder(String imageName) {
  return Container(
    margin: EdgeInsets.all(1.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      image: DecorationImage(
        image: AssetImage(imageName),
        alignment: Alignment.centerRight,
        fit: BoxFit.cover,
      ),
    ),
  );
}
