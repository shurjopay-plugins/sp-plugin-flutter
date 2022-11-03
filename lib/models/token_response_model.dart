import 'package:shurjopay/utilities/value_parser.dart';

class TokenResponseModel {
  String? token;
  int? storeId;
  String? executeUrl;
  String? tokenType;
  int? spCode;
  String? message;
  String? tokenCreateTime;
  int? expiresIn;

  TokenResponseModel(
      {this.token,
      this.storeId,
      this.executeUrl,
      this.tokenType,
      this.spCode,
      this.message,
      this.tokenCreateTime,
      this.expiresIn});

  TokenResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    storeId = json["store_id"] != null
        ? ValueParser.stringToInt(json["store_id"])
        : null;
    executeUrl = json['execute_url'];
    tokenType = json['token_type'];
    spCode = json['sp_code'] != null
        ? ValueParser.stringToInt(json['sp_code'])
        : null;
    message = json['massage'] ?? json['message'];
    tokenCreateTime = json['TokenCreateTime'];
    expiresIn = json['expires_in'] != null
        ? ValueParser.stringToInt(json['expires_in'])
        : null;
  }
}
