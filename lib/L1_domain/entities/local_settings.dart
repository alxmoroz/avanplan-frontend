// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

class LocalSettings extends LocalPersistable {
  LocalSettings({
    super.id = 'settings',
    this.launchCount = 0,
    this.version = '',
    this.flags,
  });

  int launchCount;
  String version;
  Map<String, bool>? flags;

  bool _flagValue(String code) => flags?[code] ?? false;
  void _setFlagValue(String code, bool value) {
    flags = {};
    flags![code] = value;
  }

  static const _EXPLAIN_UPDATE_DETAILS_SHOWN_FLAG = 'EXPLAIN_UPDATE_DETAILS_SHOWN_FLAG';

  bool get explainUpdateDetailsShown => _flagValue(_EXPLAIN_UPDATE_DETAILS_SHOWN_FLAG);
  void setExplainUpdateDetailsShown(bool value) => _setFlagValue(_EXPLAIN_UPDATE_DETAILS_SHOWN_FLAG, value);
}
