class InternalResponseModel {
  bool? status;
  int? errorCode;
  String? message;
  String? spOrderID;

  InternalResponseModel({
    this.status,
    this.errorCode,
    this.message,
    this.spOrderID,
  });
}
