import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';
import 'package:lezemed_mobile_app/global_widgets/custom_bottom_navigation.dart';
import 'package:lezemed_mobile_app/screens/homepage/components/homepage_body.dart';
import 'package:lezemed_mobile_app/screens/setting/setting_screen.dart';
import 'package:lezemed_mobile_app/screens/shop/shop_screen.dart';
import 'package:lezemed_mobile_app/screens/wishlist/wishlist_screen.dart';

class HomePageScreen extends StatefulWidget {
  //This is the main HomePage Widget
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _index = 0;
  set string(int value) => setState(() => _index = value);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: bottomNavigationRouting(
            _index), // Calling the below function to get the active page by sending index(which is accepted from the child widget)
        bottomNavigationBar: CustomBottomNavigationBar(
          callback: (val) => setState(() => _index = val),
        ),
      ),
    );
  }
}

typedef void IntCallback(
    int val); // Declaring a callback function in order to accept input from child widget CustomBottomNavigationBar

// Bottom Navigation bar Routing
Widget bottomNavigationRouting(int index) {
  Widget
      currentPage; // To track the current active page in the bottom navigation

  // Checking if the current page matches the index passed
  switch (index) {
    case 0:
      return currentPage = HomePageScreenBody();
    case 1:
      return currentPage = Shop();
    case 2:
      return currentPage = WishListPageScreen();
    case 3:
      return currentPage = Setting();
    default:
      return currentPage = HomePageScreenBody();
  }
}
// import 'package:flutter/material.dart';
// import 'package:lezemed_mobile_app/config/size.dart';
// import 'package:lezemed_mobile_app/global_widgets/custom_bottom_navigation.dart';
// import 'package:lezemed_mobile_app/screens/homepage/components/homepage_body.dart';
// import 'package:lezemed_mobile_app/screens/setting/setting_screen.dart';
// import 'package:lezemed_mobile_app/screens/shop/shop_screen.dart';
// import 'package:lezemed_mobile_app/screens/wishlist/wishlist_screen.dart';

// class HomePageScreen extends StatefulWidget {
//   //This is the main HomePage Widget
//   @override
//   _HomePageScreenState createState() => _HomePageScreenState();
// }

// class _HomePageScreenState extends State<HomePageScreen> {
//   int _index = 0;
//   set string(int value) => setState(() => _index = value);

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);

//     return Scaffold(
//       body: bottomNavigationRouting(
//           _index), // Calling the below function to get the active page by sending index(which is accepted from the child widget)
//       bottomNavigationBar: CustomBottomNavigationBar(
//         callback: (val) => setState(() => _index = val),
//       ),
//     );
//   }
// }

// typedef void IntCallback(
//     int val); // Declaring a callback function in order to accept input from child widget CustomBottomNavigationBar

// // Bottom Navigation bar Routing
// Widget bottomNavigationRouting(int index) {
//   Widget
//       currentPage; // To track the current active page in the bottom navigation

//   // Checking if the current page matches the index passed
//   switch (index) {
//     case 0:
//       return currentPage = HomePageScreenBody();
//     case 1:
//       return currentPage = Shop();
//     case 2:
//       return currentPage = WishListPageScreen();
//     case 3:
//       return currentPage = Setting();
//     default:
//       return currentPage = HomePageScreen();
//   }
// }
