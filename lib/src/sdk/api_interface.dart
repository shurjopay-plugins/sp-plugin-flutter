import '../../shurjopay_sdk.dart';

class ApiInterface {
  var baseUrl = AppConstants.BASE_URL_SANDBOX;

  ApiInterface(String argBaseUrl) {
    baseUrl = argBaseUrl;
  }

  String getToken() {
    return "${baseUrl}get_token";
  }

  String checkout() {
    return "${baseUrl}secret-pay";
  }

  String verify() {
    return "${baseUrl}verification";
  }
}
