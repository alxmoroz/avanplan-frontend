// Copyright (c) 2022. Alexandr Moroz

import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';

import '../../L3_app/extra/services.dart';

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

bool get isTablet {
  bool _tablet = false;
  if (_isIOs) {
    _tablet = (deviceInfo as IosDeviceInfo).model == 'iPad';
  }
  return _tablet;
}

double get onePadding => isTablet ? 24 : 12;
double get defaultBorderRadius => onePadding * 1.5;

//TODO: настройку адреса вынести на бэк? Можно хранить для типа источника импорта, например.
String get docsUrlPath => 'https://moroz.team/gercules/docs/${Intl.getCurrentLocale()}';
