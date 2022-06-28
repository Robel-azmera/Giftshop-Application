import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezemed_mobile_app/config/palete.dart';

import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/models/favourite.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';
import 'package:lezemed_mobile_app/models/wishlist.dart';
import 'package:lezemed_mobile_app/scoped_model/connected_model.dart';
import 'package:lezemed_mobile_app/screens/base/base_view.dart';
import 'package:lezemed_mobile_app/screens/homepage/homepage_screen.dart';
import 'package:lezemed_mobile_app/screens/onboarding/onboarding_screen.dart';
import 'package:lezemed_mobile_app/screens/splash/splash_screen.dart';
import 'package:lezemed_mobile_app/service_locator.dart';
import 'package:lezemed_mobile_app/util_functions/routes.dart';
import 'package:lezemed_mobile_app/util_functions/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:crypto/crypto.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  //Hive initializing
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //Registering the Adapters
  Hive.registerAdapter(WishlistAdapter());
  Hive.registerAdapter(CartAdapter());
  Hive.registerAdapter(PriceInfoAdapter());
  Hive.registerAdapter(FavouriteAdapter());

  //Opens the hive boxes
  await Hive.openBox<Wishlist>('wishlist');
  await Hive.openBox<Cart>('cart');
  await Hive.openBox<PriceInfo>('price_info');
  await Hive.openBox<Favourite>('favourite');

  // Flutter config setup
  await FlutterConfig.loadEnvVariables();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Changes Status Bar Color to White
    // FlutterStatusbarcolor.setStatusBarColor(kBackgroundColor);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return BaseView<ConnectedModel>(
      builder: (context, child, model) => GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lezemed Gift Shop',
          theme: ThemeData(
            scaffoldBackgroundColor:
                model.isDarkModeEnabled ? Colors.black : kBackgroundColor,
            brightness:
                model.isDarkModeEnabled ? Brightness.dark : Brightness.light,
            fontFamily: "Montserrat",
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
              bodyText1: TextStyle(color: kTextColor),
              bodyText2: TextStyle(color: kTextColor),
            ),
          ),
          home: CheckSplashAndOnBoardingStatus(),
        ),
      ),
    );
  }
}

class CheckSplashAndOnBoardingStatus extends StatefulWidget {
  const CheckSplashAndOnBoardingStatus({Key key}) : super(key: key);
  @override
  _CheckSplashAndOnBoardingStatusState createState() =>
      _CheckSplashAndOnBoardingStatusState();
}

class _CheckSplashAndOnBoardingStatusState
    extends State<CheckSplashAndOnBoardingStatus>
    with AfterLayoutMixin<CheckSplashAndOnBoardingStatus> {
  Future checkFirstSeenAndSplashDuration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool _seen = (prefs.getBool('isFirstSeen') ?? false);
    bool _isConnected = await Util().checkInternetConnection();

    // Making dark mode false when the app starts
    // await prefs.setBool('isDarkModeEnabled', false);

    if (_seen) {
      if (_isConnected) {
        Timer(
            Duration(seconds: 3),
            () =>
                Routes().pushReplacementNavigation(context, HomePageScreen()));
      }
    } else {
      await prefs.setBool('isFirstSeen', true);
      Timer(Duration(seconds: 3),
          () => Routes().navigation(context, OnBoardingScreen()));
    }

    // Else we will see the set the 'isFirstSeen' value in
    // the shared_preferences to true
    // and navigate to the onBoarding screen with Timer
  }

  @override
  void afterFirstLayout(BuildContext context) =>
      checkFirstSeenAndSplashDuration();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SplashScreen(),
    );
  }
}

// TO BE USED WITH
// Widget getBodyUi(ViewState currentState) {
//   switch (currentState) {
//     case ViewState.Busy:
//       return CircularProgressIndicator();
//     case ViewState.Retrived:
//     default:
//       return null;
//   }
// }
