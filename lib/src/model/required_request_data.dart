import "dart:convert";
import "dart:core";

import "package:flutter/cupertino.dart";

class RequiredRequestData {
  final String username;
  final String password;
  final String prefix;
  final String currency;
  final double amount;
  final String orderId;
  final double? discountAmount; //
  final double? discPercent; //
  final String customerName;
  final String customerPhone;
  final String? customerEmail; //
  final String customerAddress;
  final String? customerCity;
  final String? customerState; //
  final String? customerPostcode;
  final String? customerCountry;
  final String? returnUrl;
  final String? cancelUrl;
  final String? clientIp;
  final String? value1;
  final String? value2;
  final String? value3;
  final String? value4;

  RequiredRequestData({
    required this.username,
    required this.password,
    required this.prefix,
    required this.currency,
    required this.amount,
    required this.orderId,
    this.discountAmount,
    this.discPercent,
    required this.customerName,
    required this.customerPhone,
    this.customerEmail,
    required this.customerAddress,
    this.customerCity,
    this.customerState,
    this.customerPostcode,
    this.customerCountry,
    this.returnUrl,
    this.cancelUrl,
    this.clientIp,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["username"]          = this.username;
    data["password"]          = this.password;
    data["prefix"]            = this.prefix;
    data["currency"]          = this.currency;
    data["amount"]            = this.amount;
    data["order_id"]          = this.orderId;
    data["discount_amount"]   = this.discountAmount;
    //
    data["disc_percent"]      = this.discPercent;
    data["customer_name"]     = this.customerName;
    data["customer_phone"]    = this.customerPhone;
    data["customer_email"]    = this.customerEmail;
    data["customer_address"]  = this.customerAddress;
    data["customer_city"]     = this.customerCity;
    data["customer_state"]    = this.customerState;
    data["customer_postcode"] = this.customerPostcode;
    //
    data["customer_country"]  = this.customerCountry;
    data["return_url"]        = this.returnUrl;
    data["cancel_url"]        = this.cancelUrl;
    data["client_ip"]         = this.clientIp;
    data["value1"]            = this.value1;
    data["value2"]            = this.value2;
    data["value3"]            = this.value3;
    data["value4"]            = this.value4;
    return data;
  }
  void onPrint() {
    var data = json.encode(toJson());
    debugPrint("DEBUG_LOG_PRINT: REQUEST_DATA: $data");
  }
}
