import 'package:shurjopay_sdk/shurjopay_sdk.dart';

import 'api_interface.dart';

class ApiClient {
  static ApiInterface getApiClient(String sdkType) {
    return ApiInterface(getBaseUrl(sdkType));
  }
  static String getBaseUrl(String sdkType) {
    var baseUrl = AppConstants.BASE_URL_SANDBOX;
    if (sdkType == AppConstants.SDK_TYPE_SANDBOX) {
      baseUrl = AppConstants.BASE_URL_SANDBOX;
    } else if (sdkType == AppConstants.SDK_TYPE_LIVE) {
      baseUrl = AppConstants.BASE_URL_LIVE;
    } else if (sdkType == AppConstants.SDK_TYPE_IPN_SANDBOX) {
      baseUrl = AppConstants.BASE_URL_IPN_SANDBOX;
    } else if (sdkType == AppConstants.SDK_TYPE_IPN_LIVE) {
      baseUrl = AppConstants.BASE_URL_IPN_LIVE;
    }
    return baseUrl;
  }
}
