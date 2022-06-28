import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/controller/wishlist_controller.dart';
import 'package:lezemed_mobile_app/global_widgets/network_sensitivity.dart';
import 'package:lezemed_mobile_app/global_widgets/no_data.dart';
import 'package:lezemed_mobile_app/models/wishlist.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';

// Scrolling Search Page Builder - List View of items
Widget wishListPageResultsBuilder({ProductModel model}) {
  return Expanded(
    flex: 1,
    child: NetworkSensitivity(
      child: ValueListenableBuilder<Box<Wishlist>>(
          valueListenable: WishlistController.getWishlist().listenable(),
          builder: (context, box, _) {
            final wishlist = box.values.toList().cast<Wishlist>();
            return wishlist.length > 0
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: wishlist.length,
                    itemBuilder: (context, index) {
                      return scrollingWishListItemBuilder(
                          id: wishlist[index].id,
                          imageLocation: wishlist[index].images,
                          title: wishlist[index].name,
                          price: int.parse(wishlist[index].price),
                          model: model);
                    },
                  )
                : NoDataIndicator(
                    message: AppStrings.noWishlistMessage, type: "NO_DATA");
          }),
    ),
  );
}

//return items to be displayed in the search scroll list
Widget scrollingWishListItemBuilder({
  int id,
  String title,
  int price,
  String imageLocation,
  ProductModel model,
}) {
  return Column(
    children: [
      ListTile(
        onTap: () {},
        leading: Image.network(
          imageLocation,
          width: getProportionateScreenWidth(100),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: getProportionateScreenHeight(10.0),
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
                ),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            model.deleteWishlist(id);
            // model.deleteFavourite(id);
          },
          icon: Icon(
            FontAwesome.close,
            size: 15,
          ),
          color: kPrimaryColor,
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
