import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shurjopay_sdk/shurjopay_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('shurjopay_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ShurjopaySdk.platformVersion, '42');
  });
}
