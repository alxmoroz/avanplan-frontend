// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/workspace.dart';
import 'source_ext.dart';

extension WSourcesExt on Workspace {
  void checkSources() => sources.forEach((src) => src.checkConnection(this));

  void updateSourceInList(Source? _s) {
    if (_s != null) {
      final index = sources.indexWhere((s) => s.id == _s.id);
      if (index >= 0) {
        if (_s.removed) {
          sources.remove(_s);
        } else {
          sources[index] = _s;
        }
      } else {
        sources.add(_s);
      }
    }
  }
}
