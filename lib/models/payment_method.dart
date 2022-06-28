class PaymentMethod {
  String paymentMethod;
  String PaymentMethodTitle;
  String description;
  bool setPaid;

  PaymentMethod({
    this.setPaid,
    this.description,
    this.PaymentMethodTitle,
    this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.PaymentMethodTitle;
    data['setpaid'] = this.setPaid;
  }
}
