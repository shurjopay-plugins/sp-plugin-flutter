class CheckoutResponseModel {
  String? checkoutUrl;
  int? amount;
  String? currency;
  String? spOrderId;
  String? customerOrderId;
  String? customerName;
  String? customerAddress;
  String? customerCity;
  String? customerPhone;
  String? customerEmail;
  String? clientIp;
  String? intent;
  String? transactionStatus;

  CheckoutResponseModel(
      {this.checkoutUrl,
      this.amount,
      this.currency,
      this.spOrderId,
      this.customerOrderId,
      this.customerName,
      this.customerAddress,
      this.customerCity,
      this.customerPhone,
      this.customerEmail,
      this.clientIp,
      this.intent,
      this.transactionStatus});

  CheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    checkoutUrl = json['checkout_url'];
    amount = json['amount'];
    currency = json['currency'];
    spOrderId = json['sp_order_id'];
    customerOrderId = json['customer_order_id'];
    customerName = json['customer_name'];
    customerAddress = json['customer_address'];
    customerCity = json['customer_city'];
    customerPhone = json['customer_phone'];
    customerEmail = json['customer_email'];
    clientIp = json['client_ip'];
    intent = json['intent'];
    transactionStatus = json['transactionStatus'];
  }
}
