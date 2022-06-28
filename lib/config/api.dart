import 'package:flutter_config/flutter_config.dart';

class API {
  static String consumerKey = FlutterConfig.get('CONSUMER_KEY');
  static String consumerSecret = FlutterConfig.get('CONSUMER_SECRET');
  static String url = FlutterConfig.get('API_URL');

  static String tokenURL = "";
  static String customersURL = FlutterConfig.get('CUSTOMER_URL');

  // API Endpoints
  static String productURL = FlutterConfig.get('PRODUCT_URL');
  static String variationURL = FlutterConfig.get('VARIATION_URL');
  static String orderURL = FlutterConfig.get('ORDER_URL');
  static String reviewURL = FlutterConfig.get('REVIEW_URL');
  static String categoryURL = FlutterConfig.get('CATEGORY_URL');
  static String categoryProductURL = FlutterConfig.get('CATEGORY_PRODUCT_URL');
  static String orderNote = FlutterConfig.get('ORDER_NOTE');

  static String paymentApiUrl = FlutterConfig.get('PAYMENT_API_URL');
  static String stripe_secret = '';

  // ID
  static String newArrivalTagid = FlutterConfig.get('NEW_ARRIVAL_ID');

  //Stripe Information
  static String publishable_key = FlutterConfig.get('PUBLISHABLE_KEY');
  static String secret_key = FlutterConfig.get('SECRET_KEY');
}
