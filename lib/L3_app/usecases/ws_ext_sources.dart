// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/workspace.dart';
import 'source_ext.dart';

extension WSourcesExt on Workspace {
  void checkSources() => sources.forEach((src) => src.checkConnection(this));
}
