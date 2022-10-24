// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

BaseDeviceInfo get deviceInfo => GetIt.I<BaseDeviceInfo>();
PackageInfo get packageInfo => GetIt.I<PackageInfo>();

bool get isWeb => deviceInfo is WebBrowserInfo;
bool get _isIOs => deviceInfo is IosDeviceInfo;
bool get _isAndroid => deviceInfo is AndroidDeviceInfo;

String get platformCode => _isIOs
    ? 'ios'
    : isWeb
        ? 'web'
        : _isAndroid
            ? 'android'
            : '?';

IosDeviceInfo get _iosDevInfo => deviceInfo as IosDeviceInfo;
AndroidDeviceInfo get _androidDevInfo => deviceInfo as AndroidDeviceInfo;
WebBrowserInfo get _webDevInfo => deviceInfo as WebBrowserInfo;

String get deviceModelName {
  String res = '';
  if (_isIOs) {
    res = _iosDevInfo.name ?? 'iOS device';
  } else if (_isAndroid) {
    res = _androidDevInfo.model ?? 'Android device';
  } else if (isWeb) {
    res = _webDevInfo.userAgent ?? 'Web platform';
  }
  return res;
}

String get deviceSystemInfo {
  String res = '';
  if (_isIOs) {
    res = '${_iosDevInfo.systemName ?? 'Apple OS'} ${_iosDevInfo.systemVersion ?? ''}';
  } else if (_isAndroid) {
    final osVersion = _androidDevInfo.version;
    res = '${osVersion.baseOS ?? 'Android'} ${osVersion.codename ?? ''}';
  }
  return res;
}

bool get isTablet {
  bool _tablet = false;
  if (_isIOs) {
    _tablet = _iosDevInfo.model == 'iPad';
  }
  return _tablet;
}
