import "dart:convert";

import "package:flutter/cupertino.dart";
import "package:shurjopay_sdk/src/utils/utility.dart";

class TransactionInfo {
  final int? id;
  final String orderId;
  final String? currency;
  final double? amount;
  final double? payableAmount;
  final double? discsountAmount;
  final double? discPercent;
  final double? usdAmt;
  final double? usdRate;
  final String? cardHolderName;
  final String? cardNumber;
  final String? phoneNo;
  final String? bankTrxId;
  final String? invoiceNo;
  final String? bankStatus;
  final String? customerOrderId;
  final int? spCode;
  final String? spMassage;
  final String? name;
  final String? email;
  final String? address;
  final String? city;
  final String? transactionStatus;
  final String? dateTime;
  final String? method;
  final String? value1;
  final String? value2;
  final String? value3;
  final String? value4;

  TransactionInfo({
    this.id,
    required this.orderId,
    this.currency,
    this.amount,
    this.payableAmount,
    this.discsountAmount,
    this.discPercent,
    this.usdAmt,
    this.usdRate,
    this.cardHolderName,
    this.cardNumber,
    this.phoneNo,
    this.bankTrxId,
    this.invoiceNo,
    this.bankStatus,
    this.customerOrderId,
    this.spCode,
    this.spMassage,
    this.name,
    this.email,
    this.address,
    this.city,
    this.transactionStatus,
    this.dateTime,
    this.method,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
  });

  static TransactionInfo getTransactionInfo(Map<String, dynamic> json) {
    //debugPrint("DEBUG_LOG_PRINT_URL:_verifyPayment: ${json.toString()} ${Utility.lineNumber}");
    return TransactionInfo(
      id: Utility.getInt(json["id"]),
      orderId: json["order_id"],
      currency: json["currency"],
      amount: Utility.getDouble(json["amount"]),
      payableAmount: Utility.getDouble(json["payable_amount"]),
      discsountAmount: Utility.getDouble(json["discsount_amount"]),
      discPercent: Utility.getDouble(json["disc_percent"]),
      usdAmt: Utility.getDouble(json["usd_amt"]),
      usdRate: Utility.getDouble(json["usd_rate"]),
      cardHolderName: json["card_holder_name"],
      cardNumber: json["card_number"],
      phoneNo: json["phone_no"],
      bankTrxId: json["bank_trx_id"],
      invoiceNo: json["invoice_no"],
      bankStatus: json["bank_status"],
      customerOrderId: json["customer_order_id"],
      spCode: Utility.getInt(json["sp_code"]),
      spMassage: json["sp_massage"],
      name: json["name"],
      email: json["email"],
      address: json["address"],
      city: json["city"],
      transactionStatus: json["transaction_status"],
      dateTime: json["date_time"],
      method: json["method"],
      value1: json["value1"],
      value2: json["value2"],
      value3: json["value3"],
      value4: json["value4"],
    );
  }

  factory TransactionInfo.fromJson(Map<String, dynamic> json) {
    //debugPrint("DEBUG_LOG_PRINT_URL:_verifyPayment: ${json.toString()} ${Utility.lineNumber}");
    return TransactionInfo(
      id: Utility.getInt(json["id"]),
      orderId: json["order_id"],
      currency: json["currency"],
      amount: Utility.getDouble(json["amount"]),
      payableAmount: Utility.getDouble(json["payable_amount"]),
      discsountAmount: Utility.getDouble(json["discsount_amount"]),
      discPercent: Utility.getDouble(json["disc_percent"]),
      usdAmt: Utility.getDouble(json["usd_amt"]),
      usdRate: Utility.getDouble(json["usd_rate"]),
      cardHolderName: json["card_holder_name"],
      cardNumber: json["card_number"],
      phoneNo: json["phone_no"],
      bankTrxId: json["bank_trx_id"],
      invoiceNo: json["invoice_no"],
      bankStatus: json["bank_status"],
      customerOrderId: json["customer_order_id"],
      spCode: Utility.getInt(json["sp_code"]),
      spMassage: json["sp_massage"],
      name: json["name"],
      email: json["email"],
      address: json["address"],
      city: json["city"],
      transactionStatus: json["transaction_status"],
      dateTime: json["date_time"],
      method: json["method"],
      value1: json["value1"],
      value2: json["value2"],
      value3: json["value3"],
      value4: json["value4"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"]                  = this.id;
    data["order_id"]            = this.orderId;
    data["currency"]            = this.currency;
    data["amount"]              = this.amount;
    data["payable_amount"]      = this.payableAmount;
    data["discsount_amount"]    = this.discsountAmount;
    //
    data["disc_percent"]        = this.discPercent;
    data["usd_amt"]             = this.usdAmt;
    data["usd_rate"]            = this.usdRate;
    data["card_holder_name"]    = this.cardHolderName;
    data["card_number"]         = this.cardNumber;
    data["phone_no"]            = this.phoneNo;
    //
    data["bank_trx_id"]         = this.bankTrxId;
    data["invoice_no"]          = this.invoiceNo;
    data["bank_status"]         = this.bankStatus;
    data["customer_order_id"]   = this.customerOrderId;
    data["sp_code"]             = this.spCode;
    data["sp_massage"]          = this.spMassage;
    data["name"]                = this.name;
    //
    data["email"]               = this.email;
    data["address"]             = this.address;
    data["city"]                = this.city;
    data["transaction_status"]  = this.transactionStatus;
    data["date_time"]           = this.dateTime;
    data["method"]              = this.method;
    //
    data["value1"]              = this.value1;
    data["value2"]              = this.value2;
    data["value3"]              = this.value3;
    data["value4"]              = this.value4;
    return data;
  }

  void onPrint() {
    var data = json.encode(toJson());
    debugPrint("DEBUG_LOG_PRINT: TRANSACTION_INFO_DATA: $data");
  }
}
