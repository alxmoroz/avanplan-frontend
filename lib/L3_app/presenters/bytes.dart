// Copyright (c) 2022. Alexandr Moroz

import '../extra/services.dart';

extension BytesFormatterPresenter on num {
  num get _kb => this / 1024;
  num get _mb => this / (1024 * 1024);
  num get _gb => this / (1024 * 1024 * 1024);
  num get _tb => this / (1024 * 1024 * 1024 * 1024);

  String get humanBytesStr => _tb > 1
      ? loc.count_terabytes_short(_tb.round())
      : _gb > 1
          ? loc.count_gigabytes_short(_gb.round())
          : _mb > 1
              ? loc.count_megabytes_short(_mb.round())
              : loc.count_kilobytes_short(_kb > 1 ? _kb.round() : _kb);
}
