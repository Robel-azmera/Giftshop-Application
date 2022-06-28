import 'dart:convert';

import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class OrderController {
  // Payment Controllers
  Future<void> startStripePayment() async {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            'pk_test_51IRtOXE8eS2YFyXjkPpejyDlRMuxeErCgS54mcPE830Akb6Wuero91SMhAAsCw7jxwvquV2ZUzMhXhPIuSok5Tp500Rtp3dqg5'));

    StripePayment.setStripeAccount(null);

    double amount = (10 * 100).toDouble();

    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod =
        await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
            .then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((error) {
      print(error);
    });

    startDirectStripeCharge(paymentMethod);
  }

  // Start Stripe Direct Charge
  Future<void> startDirectStripeCharge(PaymentMethod paymentMethod) async {
    print('Payment Stated');

    final http.Response response = await http.post(Uri.parse('uri'));

    if (response.body != null) {
      final paymentIntent = jsonDecode(response.body);
      final status = paymentIntent['paymentIntent']['status'];
      final account = paymentIntent['stripeAccount'];

      if (status == 'succeeded') {
        print('Payment Done');
      } else {
        StripePayment.setStripeAccount(account);
        await StripePayment.confirmPaymentIntent(PaymentIntent(
                paymentMethodId: paymentIntent['paymentIntent']
                    ['payment_method'],
                clientSecret: paymentIntent['paymentIntent']['client_secret']))
            .then((PaymentIntentResult paymentIntentResult) async {
          final paymentStatus = paymentIntentResult.status;
          if (paymentStatus == 'succeeded') {
            print('Payment Done');
          }
        });
      }
    }
  }
}
