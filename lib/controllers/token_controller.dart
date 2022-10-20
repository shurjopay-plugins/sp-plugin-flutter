import 'package:dio/dio.dart';
import 'package:shurjopay/models/token_request_model.dart';
import 'package:shurjopay/models/token_response_model.dart';
import 'package:shurjopay/utilities/api_endpoints.dart';
import 'package:shurjopay/utilities/enums.dart';
import 'package:shurjopay/utilities/functions.dart';

class TokenController {
  TokenResponseModel? tokenResponseModel = TokenResponseModel();

  Future<TokenResponseModel?> getToken({
    required TokenRequestModel tokenRequestModel,
  }) async {
    final Response response = await spHttpRequest(
      httpRequestType: HttpRequestType.post,
      path: ApiEndpoints.getToken,
      payload: tokenRequestModel.toJson(),
    );
    return tokenResponseModel = TokenResponseModel.fromJson(response.data);
  }
}
