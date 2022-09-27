class CheckoutRequestData {
  final String  token;
  final int     storeId;
  final String  prefix;
  final String  currency;
  final String  returnUrl;
  final String  cancelUrl;
  final double  amount;
  final String  orderId;
  final double? discsountAmount;
  final double? discPercent;
  final String  clientIp;
  final String  customerName;
  final String  customerPhone;
  final String? customerEmail;
  final String  customerAddress;
  final String  customerCity;
  final String? customerState;
  final String? customerPostcode;
  final String? customerCountry;
  final String? value1;
  final String? value2;
  final String? value3;
  final String? value4;

  CheckoutRequestData({
    required this.token,
    required this.storeId,
    required this.prefix,
    required this.currency,
    required this.returnUrl,
    required this.cancelUrl,
    required this.amount,
    required this.orderId,
    this.discsountAmount,
    this.discPercent,
    required this.clientIp,
    required this.customerName,
    required this.customerPhone,
    this.customerEmail,
    required this.customerAddress,
    required this.customerCity,
    this.customerState,
    this.customerPostcode,
    this.customerCountry,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
  });
}