import 'package:lezemed_mobile_app/models/cart.dart';
import 'package:lezemed_mobile_app/models/customer_detail_model.dart';

class Order {
  // int customerId;
  String paymentMethod;
  String paymentMethodTitle;
  bool setPaid;
  String transactionId;
  List<LineItems> lineItems;

  int orderId;
  String orderNumber;
  String status;
  String customer_note;
  DateTime orderDate;
  Shipping shipping;
  Billing billing;

  Order(
      {this.status,
      // this.customerId,
      this.lineItems,
      this.orderDate,
      this.orderId,
      this.orderNumber,
      this.paymentMethod,
      this.paymentMethodTitle,
      this.setPaid,
      this.shipping,
      this.transactionId,
      this.billing,
      this.customer_note});

  Order.fromJson(Map<String, dynamic> json) {
    // customerId = json['customer_id'];
    orderId = json['id'];
    status = json['status'];
    orderNumber = json['order_key'];
    orderDate = DateTime.parse(json['date_created']);
    customer_note = json['customer_note'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    // data['customer_id'] = customerId;
    data['payment_method'] = paymentMethod;
    data['payment_method_title'] = paymentMethodTitle;
    data['set_paid'] = setPaid;
    data['transaction_id'] = transactionId;
    data['shipping'] = shipping.toJson();
    data['billing'] = billing.toJson();
    data['customer_note'] = customer_note;

    if (lineItems != null) {
      data['line_items'] = lineItems.map((e) => e.toJson()).toList();
    }

    return data;
  }
}

class LineItems {
  int productId;
  int quantity;
  int variationId;

  LineItems({this.productId, this.quantity, this.variationId});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    if (this.variationId != null) {
      data['variation_id'] = this.variationId;
    }
    return data;
  }
}
