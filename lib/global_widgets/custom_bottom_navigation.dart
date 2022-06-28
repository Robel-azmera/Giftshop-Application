import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/screens/homepage/homepage_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final IntCallback callback;

  CustomBottomNavigationBar({this.callback});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _index = 0;

  // On tapped listener for managing bottom navigation item
  void _onItemTapped(int val) {
    setState(() {
      _index = val;
      widget.callback(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Platform.isIOS
          ? EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10.0)
          : EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(75),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset:
                Offset(0, 3), // changes position of shadow (x, y) coordinates
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        child: BottomNavigationBar(
          items: [
            bottomNavigationItemBuilder(
              imageLocation: 'assets/icons/home.svg',
              label: AppStrings.home,
              isSvgIcon: true,
              iconWidth: 28,
              index: 0,
            ),
            bottomNavigationItemBuilder(
              imageLocation: 'assets/icons/bags.png',
              label: AppStrings.shop,
              isSvgIcon: false,
              iconWidth: 30,
              index: 1,
            ),
            bottomNavigationItemBuilder(
              imageLocation: 'assets/icons/favourite.svg',
              label: AppStrings.wishlist,
              isSvgIcon: true,
              iconWidth: 31,
              index: 2,
            ),
            bottomNavigationItemBuilder(
              imageLocation: 'assets/icons/User.svg',
              label: AppStrings.setting,
              isSvgIcon: true,
              iconWidth: 28,
              index: 3,
            ),
          ],
          currentIndex: _index,
          elevation: 10.0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  //Bottom Navigation Bar Items Builder function
  BottomNavigationBarItem bottomNavigationItemBuilder({
    String imageLocation,
    String label,
    int index,
    bool isSvgIcon,
    double iconWidth,
  }) {
    return BottomNavigationBarItem(
        icon: Container(
          padding: Platform.isIOS ? EdgeInsets.symmetric(vertical: 10.0) : null,
          child: isSvgIcon
              ? SvgPicture.asset(
                  imageLocation,
                  width: getProportionateScreenWidth(iconWidth),
                  color: _index == index ? kSecondaryColor : Colors.black,
                )
              : Image.asset(
                  imageLocation,
                  width: getProportionateScreenWidth(iconWidth),
                  color: _index == index ? kSecondaryColor : Colors.black,
                ),
        ),
        label: label);
  }
}
