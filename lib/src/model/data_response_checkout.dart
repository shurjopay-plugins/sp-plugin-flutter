import "../utils/utility.dart";

class CheckoutResponseData {
  final String  checkoutUrl;
  final double  amount;
  final String  currency;
  final String  spOrderId;
  final String  customerOrderId;
  final String  customerName;
  final String  customerAddress;
  final String  customerCity;
  final String  customerPhone;
  final String  customerEmail;
  final String  clientIp;
  final String  intent;
  final String  transactionStatus;

  CheckoutResponseData({
    required this.checkoutUrl,
    required this.amount,
    required this.currency,
    required this.spOrderId,
    required this.customerOrderId,
    required this.customerName,
    required this.customerAddress,
    required this.customerCity,
    required this.customerPhone,
    required this.customerEmail,
    required this.clientIp,
    required this.intent,
    required this.transactionStatus,
  });

  factory CheckoutResponseData.fromJson(Map<String, dynamic> json) {
    return CheckoutResponseData(
      checkoutUrl:        json["checkout_url"],
      amount:             Utility.getDouble(json["amount"]),
      currency:           json["currency"],
      spOrderId:          json["sp_order_id"],
      customerOrderId:    json["customer_order_id"],
      customerName:       json["customer_name"],
      customerAddress:    json["customer_address"],
      customerCity:       json["customer_city"],
      customerPhone:      json["customer_phone"],
      customerEmail:      json["customer_email"],
      clientIp:           json["client_ip"],
      intent:             json["intent"],
      transactionStatus:  json["transactionStatus"],
    );
  }

  Map toMap() {
    var map = <String, dynamic>{};
    map["checkout_url"]       = checkoutUrl;
    map["amount"]             = amount;
    map["currency"]           = currency;
    map["sp_order_id"]        = spOrderId;
    map["customer_order_id"]  = customerOrderId;
    map["customer_name"]      = customerName;
    map["customer_address"]   = customerAddress;
    map["customer_city"]      = customerCity;
    map["customer_phone"]     = customerPhone;
    map["client_ip"]          = clientIp;
    map["intent"]             = intent;
    map["transactionStatus"]  = transactionStatus;
    return map;
  }
}
//{"checkout_url":"https:\/\/sandbox.securepay.shurjopayment.com\/spaycheckout\/?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc2FuZGJveC5zaHVyam9wYXltZW50LmNvbVwvYXBpXC9sb2dpbiIsImlhdCI6MTY0MTEyMzcxMywiZXhwIjoxNjQxMTI3MzEzLCJuYmYiOjE2NDExMjM3MTMsImp0aSI6Ik9xRWhCc0FyNU54a0hTMkgiLCJzdWIiOjEsInBydiI6IjgwNWYzOWVlZmNjNjhhZmQ5ODI1YjQxMjI3ZGFkMGEwNzZjNDk3OTMifQ.DIXkk0zxTYzYiN_Rir3RMHFHRoHD48mb98ryxiMGeZQ&order_id=NOK61d18f81a0b7a","amount":5,"currency":"BDT","sp_order_id":"NOK61d18f81a0b7a","customer_order_id":"PPD434","customer_name":"customer name","customer_address":"customer address","customer_city":"customer city","customer_phone":"01812166111","customer_email":"null","client_ip":"127.0.0.1","intent":"sale","transactionStatus":"Initiated"}
