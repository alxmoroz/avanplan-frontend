// Copyright (c) 2022. Alexandr Moroz

import '../extra/services.dart';

extension BytesFormatterPresenter on num {
  static const kb = 1024;
  static const mb = 1024 * 1024;
  static const gb = 1024 * 1024 * 1024;

  num get _kb => this / kb;
  num get _mb => this / mb;
  num get _gb => this / gb;

  String get humanBytesSuffix {
    return _gb >= 1
        ? loc.gigabytes_short
        : _mb >= 1
            ? loc.megabytes_short
            : loc.kilobytes_short;
  }

  String get humanBytesStr {
    return this != 0
        ? _gb >= 1
            ? '${_gb.round()} ${loc.gigabytes_short}'
            : _mb >= 1
                ? '${_mb.round()} ${loc.megabytes_short}'
                : '${_kb >= 1 ? _kb.round() : _kb} ${loc.kilobytes_short}'
        : '0 ${loc.kilobytes_short}';
  }
}
