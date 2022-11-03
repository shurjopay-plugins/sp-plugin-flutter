import 'package:flutter/foundation.dart';
import 'package:shurjopay/utilities/constants.dart';
import 'package:shurjopay/utilities/global_objects.dart';
import 'package:shurjopay/utilities/register_singleton.dart';

import '../services/dio_service.dart';
import 'enums.dart';

/// To use shurjoPay flutter package, you must initialize it at first by passing environment type.
///
/// Example:
///
/// ```dart
///  initializeShurjopay(environment: "sandbox");
/// ```
///
Future initializeShurjopay({required String environment}) async {
  await registerSingletons();
  await createDioSingleton(environment);
}

getBaseUrl(String sdkType) {
  if (sdkType == SPEnvironmentType.sandbox) {
    return SPBaseURL.sandbox;
  } else if (sdkType == SPEnvironmentType.live) {
    return SPBaseURL.live;
  } else if (sdkType == SPEnvironmentType.ipnSandbox) {
    return SPBaseURL.ipnSandbox;
  } else if (sdkType == SPEnvironmentType.ipnLive) {
    return SPBaseURL.ipnLive;
  }
  return null;
}

printer(dynamic value) {
  if (kDebugMode) {
    print(value);
  }
}

Future spHttpRequest({
  required HttpRequestType httpRequestType,
  required String path,
  dynamic payload,
}) async {
  switch (httpRequestType) {
    case HttpRequestType.get:
      return shurjoPayserviceLocator<SPDioService>().dio.get(
            path,
          );
    case HttpRequestType.post:
      return shurjoPayserviceLocator<SPDioService>().dio.post(
            path,
            data: payload,
          );
    case HttpRequestType.put:
      return shurjoPayserviceLocator<SPDioService>().dio.put(
            path,
            data: payload,
          );
    case HttpRequestType.delete:
      return shurjoPayserviceLocator<SPDioService>().dio.delete(
            path,
            data: payload,
          );
  }
}
