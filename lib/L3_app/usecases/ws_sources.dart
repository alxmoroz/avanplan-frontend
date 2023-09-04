// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/workspace.dart';
import 'source.dart';

extension WSourcesUC on Workspace {
  void checkSources() => sources.forEach((src) => src.checkConnection());
}
