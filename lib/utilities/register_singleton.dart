import 'package:shurjopay/services/dio_service.dart';
import 'package:shurjopay/utilities/functions.dart';

import 'global_objects.dart';

Future<void> registerSingletons() async {
  shurjoPayserviceLocator.registerLazySingleton(() => SPDioService());
}

Future<void> createDioSingleton(String environment) async {
  shurjoPayserviceLocator<SPDioService>().env = environment;
  await shurjoPayserviceLocator<SPDioService>().create(
    baseURL: getBaseUrl(environment),
  );
}
