import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lezemed_mobile_app/config/api.dart';
import 'package:lezemed_mobile_app/config/app_strings.dart';
import 'package:lezemed_mobile_app/global_widgets/alert_dialog.dart';
import 'package:lezemed_mobile_app/models/order.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret = API.secret_key;
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: API.publishable_key,
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  static Future<StripeTransactionResponse> payViaExistingCard(
      {String amount, String currency, CreditCard card}) async {
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());

      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);

      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
        clientSecret: paymentIntent['client_secret'],
        paymentMethodId: paymentMethod.id,
      ));

      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
        message: 'Transaction failed: ${err.toString()}===============',
        success: false,
      );
    }
  }

  static Future<Map<String, dynamic>> createcustomer({Order order}) async {
    try {
      var data = {
        'name': order.billing.firstName + ' ' + order.billing.lastName,
        'address': {
          'line1': order.billing.address1,
          'postal_code': order.billing.postcode,
          'city': order.billing.city,
          'state': order.billing.state,
          'country': order.billing.country,
        }
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/customers'),
          body: data,
          headers: StripeService.headers);

      print('response: ${jsonDecode(response.body)}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err creating user: ${err.toString()}');
    }
    return null;
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(Uri.parse(StripeService.paymentApiUrl),
          body: body, headers: StripeService.headers);
      // print('${response.statusCode}================');

      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}
