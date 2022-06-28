import 'package:get_it/get_it.dart';
import 'package:lezemed_mobile_app/controller/orders_controller.dart';
import 'package:lezemed_mobile_app/controller/product_controller.dart';
import 'package:lezemed_mobile_app/controller/utility_controller.dart';
import 'package:lezemed_mobile_app/controller/wishlist_controller.dart';
import 'package:lezemed_mobile_app/scoped_model/connected_model.dart';
import 'package:lezemed_mobile_app/scoped_model/home_model.dart';
import 'package:lezemed_mobile_app/scoped_model/order_model.dart';
import 'package:lezemed_mobile_app/scoped_model/product_model.dart';
import 'package:lezemed_mobile_app/scoped_model/utility_model.dart';
import 'package:lezemed_mobile_app/scoped_model/wishlist_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<UtilityController>(() => UtilityController());
  locator.registerLazySingleton<ProductController>(() => ProductController());
  locator.registerLazySingleton<WishlistController>(() => WishlistController());
  locator.registerLazySingleton<OrderController>(() => OrderController());

  // Register models
  locator.registerFactory<ConnectedModel>(() => ConnectedModel());
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<UtilityModel>(() => UtilityModel());
  locator.registerFactory<ProductModel>(() => ProductModel());
  locator.registerFactory<WishlistModel>(() => WishlistModel());
  locator.registerFactory<OrderModel>(() => OrderModel());
}
