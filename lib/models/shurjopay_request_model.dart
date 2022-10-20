class ShurjopayRequestModel {
  final String userName;
  final String password;
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
  final String customerCity;
  final String? customerState;
  final String customerPostcode;
  final String? customerCountry;
  final String returnURL;
  final String cancelURL;
  final String? clientIP;
  final String? value1;
  final String? value2;
  final String? value3;
  final String? value4;

  ShurjopayRequestModel({
    required this.userName,
    required this.password,
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
    required this.customerCity,
    this.customerState,
    required this.customerPostcode,
    this.customerCountry,
    required this.returnURL,
    required this.cancelURL,
    this.clientIP,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
  });
}
