import 'dart:convert';
import 'package:lezemed_mobile_app/config/api.dart';
import 'package:lezemed_mobile_app/models/customer_detail_model.dart';
import 'package:lezemed_mobile_app/models/order.dart';
import 'package:lezemed_mobile_app/util_functions/util.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class OrderController {
  bool _isOrderCreated = false;

  Future<void> startStripePayment() async {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            'pk_test_51IRtOXE8eS2YFyXjkPpejyDlRMuxeErCgS54mcPE830Akb6Wuero91SMhAAsCw7jxwvquV2ZUzMhXhPIuSok5Tp500Rtp3dqg5'));

    StripePayment.setStripeAccount(null);

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

  // Fetching Customer details
  Future<List<CustomerDetailsModel>> getCustomerDetail() async {
    List<CustomerDetailsModel> data = [];

    try {
      String url = Util().getOAuthURL('GET', API.url + API.customersURL);
      print('$url');
      final http.Response response = await http
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

      print('${response.body}');
      if (response.statusCode == 200) {
        data = (jsonDecode(response.body) as List)
            .map(
              (i) => CustomerDetailsModel.fromJSON(i),
            )
            .toList()
            .cast<CustomerDetailsModel>();
      }
    } catch (error) {
      print(error);
    }

    return data;
  }

  //Create Order
  Future<bool> createOrder({Order orderModel}) async {
    bool isOrderCreated = false;

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');

    try {
      String url = Util().getOAuthURL('POST', API.url + API.orderURL);

      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderModel.toJson()),
      );

      if (response.statusCode == 201) {
        // var orderResponse = jsonDecode(response.body);

        // var createOrderNoteResponse = await createOrderNote(
        //     orderResponse['id'].toString(), orderModel.shipping.note);

        isOrderCreated = true;
      }
    } catch (error) {
      print(error.toString());
    }
    return isOrderCreated;
  }

  Future<bool> createOrderNote(String orderID, String orderNote) async {
    bool isNoteCreated = false;

    try {
      String url = Util().getOAuthURL(
          'POST', API.url + API.orderURL + "/" + orderID + API.orderNote);

      var response = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode({"note": orderNote, "customer_note": true}));
      print(response.statusCode);

      if (response.statusCode == 201) {
        isNoteCreated = true;
      }
    } catch (error) {
      print(error.toString());
    }
    return isNoteCreated;
  }
}
