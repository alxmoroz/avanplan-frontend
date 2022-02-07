// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:openapi/openapi.dart';
import 'package:package_info/package_info.dart';

import '../L2_app/l10n/generated/l10n.dart';
import '../L2_app/views/auth/login_controller.dart';
import '../L2_app/views/main/main_controller.dart';
import '../L3_data/repositories/hive_storage.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

IosDeviceInfo get iosInfo => GetIt.I<IosDeviceInfo>();
PackageInfo get packageInfo => GetIt.I<PackageInfo>();

HStorage get hStorage => GetIt.I<HStorage>();

MainController get mainController => GetIt.I<MainController>();
LoginController get loginController => GetIt.I<LoginController>();
Openapi get openAPI => GetIt.I<Openapi>();

void setup() {
  // device
  getIt.registerSingletonAsync<IosDeviceInfo>(() async => await DeviceInfoPlugin().iosInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  // repo / adapters
  getIt.registerSingletonAsync<HStorage>(() async => await HStorage().init());
  getIt.registerSingletonAsync<Openapi>(() async {
    final api = Openapi(basePathOverride: 'http://localhost:8000/');
    api.dio.options.connectTimeout = 10000;
    return api;
  });

  // stores / states / controllers
  getIt.registerSingletonAsync<MainController>(
    () async => await MainController().init(),
    dependsOn: [HStorage, PackageInfo, IosDeviceInfo, Openapi],
  );
  getIt.registerSingletonAsync<LoginController>(() async => await LoginController().init(), dependsOn: [MainController]);
}
