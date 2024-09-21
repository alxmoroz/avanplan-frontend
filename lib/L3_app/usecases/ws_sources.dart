// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/remote_source.dart';
import '../../L1_domain/entities/workspace.dart';
import 'source.dart';

extension WSourcesUC on Workspace {
  void checkSources() {
    for (RemoteSource s in sources) {
      s.checkConnection();
    }
  }
}
