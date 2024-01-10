// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/workspace.dart';
import 'source.dart';

extension WSourcesUC on Workspace {
  void checkSources() {
    for (Source s in sources) {
      s.checkConnection();
    }
  }
}
