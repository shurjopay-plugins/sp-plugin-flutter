class ShurjopayResponseModel {
  bool? status;
  int? errorCode;
  String? message;
  String? shurjopayOrderID;

  ShurjopayResponseModel({
    this.status,
    this.errorCode,
    this.message,
    this.shurjopayOrderID,
  });
}
