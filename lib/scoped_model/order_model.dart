import 'dart:convert';

import 'package:lezemed_mobile_app/controller/orders_controller.dart';
import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/models/customer_detail_model.dart';
import 'package:lezemed_mobile_app/models/order.dart';
import 'package:lezemed_mobile_app/models/price_info.dart';
import 'package:lezemed_mobile_app/scoped_model/base_model.dart';
import 'package:lezemed_mobile_app/service_locator.dart';
import 'package:stripe_payment/stripe_payment.dart';

class OrderModel extends BaseModel {
  OrderController orderController = locator<OrderController>();

  List<Order> _list = []; //list that stores Note objects
  bool _isOrderCreated = false;

  bool get isOrderCreated => _isOrderCreated;

  List<Order> get orderList {
    return [..._list];
  }

  Future<List<CustomerDetailsModel>> getCustomerDetail() async {
    return await orderController.getCustomerDetail();
  }

  Future<bool> createOrder(
    Order order,
    List<PriceInfo> items,
  ) async {
    if (order.shipping == null) {
      order.shipping = new Shipping();
      print(order.shipping == null);
    }
    if (order.lineItems == null) {
      order.lineItems = <LineItems>[];
    }

    order.paymentMethod = "stripe";
    order.paymentMethodTitle = "Direct Bank Transfer";
    // order.setPaid = true;

    items.forEach((val) {
      order.lineItems.add(
        new LineItems(
          productId: val.id,
          quantity: val.amount,
        ),
      );
    });

    return await orderController.createOrder(orderModel: order);
  }
}
