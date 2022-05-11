// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';

import '../../L3_app/extra/services.dart';

bool get isTablet {
  bool _tablet = false;
  if (deviceInfo is IosDeviceInfo) {
    _tablet = (deviceInfo as IosDeviceInfo).model == 'iPad';
  }
  return _tablet;
}

double get onePadding => isTablet ? 24 : 12;
