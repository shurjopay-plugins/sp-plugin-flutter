import 'package:shurjopay/models/config.dart';

class ShurjopayRequestModel {
  /// Pass prefix, user name, password and client ip as configs here
  ShurjopayConfigs configs;

  /// ISO format,(only BDT and USD are allowed)
  final String currency;

  /// Transaction amount
  final double amount;

  /// Unique Order Id from merchant store.
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

  /// Additional field
  final String? value1;

  /// Additional field
  final String? value2;

  /// Additional field
  final String? value3;

  /// Additional field
  final String? value4;

  ShurjopayRequestModel({
    required this.configs,
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
    this.value1,
    this.value2,
    this.value3,
    this.value4,
  });
}
