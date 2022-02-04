// Copyright (c) 2021. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';

import '../L2_app/l10n/generated/l10n.dart';
import '../L2_app/views/main/main_controller.dart';
import '../L3_data/repositories/hive_storage.dart';

S get loc => S.current;

GetIt getIt = GetIt.instance;

IosDeviceInfo get iosInfo => GetIt.I<IosDeviceInfo>();
PackageInfo get packageInfo => GetIt.I<PackageInfo>();

HStorage get hStorage => GetIt.I<HStorage>();

MainController get mainController => GetIt.I<MainController>();

void setup() {
  // device
  getIt.registerSingletonAsync<IosDeviceInfo>(() async => await DeviceInfoPlugin().iosInfo);
  getIt.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());

  // repo / adapters
  getIt.registerSingletonAsync<HStorage>(() async => await HStorage().init());

  // stores / states / controllers
  getIt.registerSingletonAsync<MainController>(
    () async => await MainController().init(),
    dependsOn: [HStorage, PackageInfo, IosDeviceInfo],
  );
}
