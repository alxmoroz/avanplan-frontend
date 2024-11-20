// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/remote_source.dart';
import '../entities/workspace.dart';

// TODO: сделать так же как со статусами

extension RemoteSourceExtension on Workspace {
  RemoteSource? remoteSourceForId(int? id) => sources.firstWhereOrNull((s) => s.id == id);

  void updateRemoteSourceInList(RemoteSource? s) {
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
