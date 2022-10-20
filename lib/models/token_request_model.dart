class TokenRequestModel {
  final String userName;
  final String password;

  TokenRequestModel({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = userName;
    map['password'] = password;

    return map;
  }
}
