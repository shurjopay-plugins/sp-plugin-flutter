import 'package:shurjopay/utilities/value_parser.dart';

class ShurjopayVerificationModel {
  int? id;
  String? orderId;
  String? currency;
  int? amount;
  int? payableAmount;
  int? discsountAmount;
  int? discPercent;
  String? receivedAmount;
  int? usdAmt;
  int? usdRate;
  String? cardHolderName;
  String? cardNumber;
  String? phoneNo;
  String? bankTrxId;
  String? invoiceNo;
  String? bankStatus;
  String? customerOrderId;
  String? spCode;
  String? spMessage;
  String? name;
  String? email;
  String? address;
  String? city;
  String? value1;
  String? value2;
  String? value3;
  String? value4;
  String? transactionStatus;
  String? method;
  String? dateTime;
  String? message;

  ShurjopayVerificationModel({
    this.id,
    this.orderId,
    this.currency,
    this.amount,
    this.payableAmount,
    this.discsountAmount,
    this.discPercent,
    this.receivedAmount,
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
    this.spMessage,
    this.name,
    this.email,
    this.address,
    this.city,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
    this.transactionStatus,
    this.method,
    this.dateTime,
    this.message,
  });

  ShurjopayVerificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    currency = json['currency'];
    amount = json['amount'];
    payableAmount = json['payable_amount'];
    discsountAmount = json['discsount_amount'];
    discPercent = json['disc_percent'];
    receivedAmount = json['received_amount'];
    usdAmt = json['usd_amt'];
    usdRate = json['usd_rate'];
    cardHolderName = json['card_holder_name'];
    cardNumber = json['card_number'];
    phoneNo = json['phone_no'];
    bankTrxId = json['bank_trx_id'];
    invoiceNo = json['invoice_no'];
    bankStatus = json['bank_status'];
    customerOrderId = json['customer_order_id'];
    spCode = json['sp_code'] != null
        ? ValueParser.intToSring(json['sp_code'])
        : null;
    spMessage = json['sp_message'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    value1 = json['value1'];
    value2 = json['value2'];
    value3 = json['value3'];
    value4 = json['value4'];
    transactionStatus = json['transaction_status'];
    method = json['method'];
    dateTime = json['date_time'];
    message = json['message'];
  }
}
