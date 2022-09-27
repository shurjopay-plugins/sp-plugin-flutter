import "package:shurjopay_sdk/shurjopay_sdk.dart";
//import "../../shurjopay_sdk.dart';

class ErrorSuccess {
  late TransactionInfo? transactionInfo;
  ESType esType = ESType.NONE;
  String message = "";
  bool isLastCallback = false;

  ErrorSuccess(ESType esType, TransactionInfo? transactionInfo, String message, {bool isLastCallback = false}) {
    this.esType   = esType;
    this.transactionInfo = transactionInfo;
    this.message  = message;
    this.isLastCallback = isLastCallback;
  }
}
