// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';
import 'source_ext.dart';

extension WSourcesExt on Workspace {
  void checkSources() => sources.forEach((src) => src.checkConnection());

  Future updateSourceInList(Source? _s) async {
    if (_s != null) {
      final index = sources.indexWhere((s) => s.id == _s.id);
      if (index >= 0) {
        if (_s.deleted) {
          sources.remove(_s);
        } else {
          sources[index] = _s;
        }
      } else {
        sources.add(_s);
      }
      mainController.touchWorkspaces();
    }
  }
}
