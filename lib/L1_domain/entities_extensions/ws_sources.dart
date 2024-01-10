// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/source.dart';
import '../entities/source_type.dart';
import '../entities/workspace.dart';

// TODO: сделать так же как со статусами

extension WSSources on Workspace {
  Source? sourceForId(int? id) => sources.firstWhereOrNull((s) => s.id == id);
  Source? sourceForType(SourceType? type) => sources.firstWhereOrNull((s) => s.typeCode == type?.code);

  void updateSourceInList(Source? s) {
    if (s != null) {
      final index = sources.indexWhere((s) => s.id == s.id);
      if (index >= 0) {
        if (s.removed) {
          sources.remove(s);
        } else {
          sources[index] = s;
        }
      } else {
        sources.add(s);
      }
    }
  }
}
