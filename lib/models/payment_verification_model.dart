class ShurjopayVerificationModel {
  String? orderId;
  String? currency;
  int? amount;
  int? payableAmount;
  int? discsountAmount;
  int? discPercent;
  int? usdAmt;
  int? usdRate;
  String? method;
  String? spMassage;
  int? spCode;
  String? name;
  String? email;
  String? address;
  String? city;
  String? value1;
  String? value2;
  String? value3;
  String? value4;
  String? message;

  ShurjopayVerificationModel({
    this.orderId,
    this.currency,
    this.amount,
    this.payableAmount,
    this.discsountAmount,
    this.discPercent,
    this.usdAmt,
    this.usdRate,
    this.method,
    this.spMassage,
    this.spCode,
    this.name,
    this.email,
    this.address,
    this.city,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
    this.message,
  });

  ShurjopayVerificationModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    currency = json['currency'];
    amount = json['amount'];
    payableAmount = json['payable_amount'];
    discsountAmount = json['discsount_amount'];
    discPercent = json['disc_percent'];
    usdAmt = json['usd_amt'];
    usdRate = json['usd_rate'];
    method = json['method'];
    spMassage = json['sp_massage'];
    spCode = json['sp_code'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    value1 = json['value1'];
    value2 = json['value2'];
    value3 = json['value3'];
    value4 = json['value4'];
    message = json['message'];
  }
}
