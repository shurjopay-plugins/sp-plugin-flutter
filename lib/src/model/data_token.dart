import "package:shurjopay_sdk/src/utils/utility.dart";

class Token {
  final String? username;
  final String? password;
  final String? token;
  final int?    storeId;
  final String? executeUrl;
  final String? tokenType;
  final int?    spCode;
  final String? massage;
  final int?    expiresIn;

  Token({
    this.username,
    this.password,
    this.token,
    this.storeId,
    this.executeUrl,
    this.tokenType,
    this.spCode,
    this.massage,
    this.expiresIn,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      username:   json["username"],
      password:   json["password"],
      token:      json["token"],
      storeId:    Utility.getInt(json["store_id"]),
      executeUrl: json["execute_url"],
      tokenType:  json["token_type"],
      spCode:     Utility.getInt(json["sp_code"]),
      massage:    json["massage"],
      expiresIn:  Utility.getInt(json["expires_in"]),
    );
  }

  Map toMap() {
    var map             = <String, dynamic>{};
    map["username"]     = username;
    map["password"]     = password;
    map["token"]        = token;
    map["store_id"]     = storeId;
    map["execute_url"]  = executeUrl;
    map["token_type"]   = tokenType;
    map["sp_code"]      = spCode;
    map["massage"]      = massage;
    map["expires_in"]   = expiresIn;
    return map;
  }
}
