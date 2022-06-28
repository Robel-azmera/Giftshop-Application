import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/screens/cart/cart_screen.dart';
import 'package:lezemed_mobile_app/screens/search/search_screen.dart';
import 'package:lezemed_mobile_app/util_functions/routes.dart';

//Builds App bar of the homepage
// Currently not in use
Padding customHomePageAppBar() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: getProportionateScreenWidth(40),
          height: getProportionateScreenWidth(40),
          child: new FloatingActionButton(
            heroTag: 'search',
            backgroundColor: Colors.white,
            child: Icon(
              Icons.search,
              color: kPrimaryColor,
            ),
            onPressed: () {},
          ),
        ),
        Text(
          AppStrings.fullAppName,
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        Container(
          width: getProportionateScreenWidth(40),
          height: getProportionateScreenWidth(40),
          child: new FloatingActionButton(
            heroTag: 'cart',
            backgroundColor: Colors.white,
            child: Icon(
              Icons.shopping_cart,
              color: kPrimaryColor,
            ),
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}

// Used for all screens
Widget customAppBar({
  @required String title,
  @required bool isRightIconVisible,
  @required bool isLeftIconBack,
  @required BuildContext context,
  @required int amount,
}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: getProportionateScreenWidth(40),
          height: getProportionateScreenWidth(40),
          child: new FloatingActionButton(
            heroTag: 'search',
            backgroundColor: Colors.white,
            child: isLeftIconBack
                ? Padding(
                    padding: EdgeInsets.only(left: Platform.isIOS ? 5.0 : 7.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      color: kPrimaryColor,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      Routes().navigation(context, SearchPageScreen());
                    },
                    icon: Icon(Icons.search),
                    color: kPrimaryColor,
                  ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        isRightIconVisible
            ? Container(
                width: getProportionateScreenWidth(40),
                height: getProportionateScreenWidth(40),
                child: new FloatingActionButton(
                  heroTag: 'cart',
                  backgroundColor: Colors.white,
                  child: Badge(
                    position: BadgePosition.topEnd(end: -13, top: -13),
                    badgeContent: Text(
                      '$amount',
                      style: TextStyle(
                        color: kBackgroundColor,
                        fontSize: 9,
                      ),
                    ),
                    badgeColor: kSecondaryColor,
                    child: Icon(
                      Icons.shopping_cart,
                      color: kPrimaryColor,
                    ),
                  ),
                  onPressed: () {
                    Routes().navigation(context, CartPageScreen());
                  },
                ),
              )
            : Container(
                child: SizedBox(
                  width: getProportionateScreenWidth(35.0),
                ),
              ),
      ],
    ),
  );
}
