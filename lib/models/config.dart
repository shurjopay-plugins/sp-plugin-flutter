class ShurjopayConfigs {
  /// shurjoPay merchant user name
  final String userName;

  /// shurjoPay merchant password
  final String password;

  /// Any string not more than 5 characters. It distinguishes the stores of a merchant.
  final String prefix;
  String clientIP;

  ShurjopayConfigs({
    required this.prefix,
    required this.userName,
    required this.password,
    required this.clientIP,
  });
}
