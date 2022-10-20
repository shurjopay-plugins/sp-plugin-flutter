import 'package:dio/dio.dart';
import 'package:shurjopay/models/checkout_request_model.dart';
import 'package:shurjopay/models/checkout_response_model.dart';
import 'package:shurjopay/utilities/api_endpoints.dart';
import 'package:shurjopay/utilities/enums.dart';
import 'package:shurjopay/utilities/functions.dart';

class CheckoutController {
  Future<CheckoutResponseModel?> checkout({
    required CheckoutRequestModel checkoutRequestModel,
  }) async {
    final Response response = await spHttpRequest(
      httpRequestType: HttpRequestType.post,
      path: ApiEndpoints.checkout,
      payload: checkoutRequestModel.toJson(),
    );
    return CheckoutResponseModel.fromJson(response.data);
  }
}
