class CheckoutRequestModel {
  final String token;
  final String storeID;
  final String prefix;
  final String currency;
  final double amount;
  final String orderID;
  final double? discountAmount;
  final double? discountPercentage;
  final String customerName;
  final String customerPhoneNumber;
  final String? customerEmail;
  final String customerAddress;
  final String? customerCity;
  final String? customerState;
  final String? customerPostcode;
  final String? customerCountry;
  final String? returnURL;
  final String? cancelURL;
  final String? clientIP;
  final String? value1;
  final String? value2;
  final String? value3;
  final String? value4;

  CheckoutRequestModel({
    required this.token,
    required this.storeID,
    required this.prefix,
    required this.currency,
    required this.amount,
    required this.orderID,
    this.discountAmount,
    this.discountPercentage,
    required this.customerName,
    required this.customerPhoneNumber,
    this.customerEmail,
    required this.customerAddress,
    this.customerCity,
    this.customerState,
    this.customerPostcode,
    this.customerCountry,
    this.returnURL,
    this.cancelURL,
    this.clientIP,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['store_id'] = storeID;
    map['prefix'] = prefix;
    map['currency'] = currency;
    map['amount'] = amount;
    map['order_id'] = orderID;
    map['discsount_amount'] = discountAmount;
    map['disc_percent'] = discountPercentage;
    map['client_ip'] = clientIP;
    map['customer_name'] = customerName;
    map['customer_phone'] = customerPhoneNumber;
    map['customer_email'] = customerEmail;
    map['customer_address'] = customerAddress;
    map['customer_city'] = customerCity;
    map['customer_state'] = customerState;
    map['customer_postcode'] = customerPostcode;
    map['customer_country'] = customerCountry;
    map['return_url'] = returnURL;
    map['cancel_url'] = cancelURL;
    map['value1'] = value1;
    map['value2'] = value2;
    map['value3'] = value3;
    map['value4'] = value4;
    return map;
  }
}
