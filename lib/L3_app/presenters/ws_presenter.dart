// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/workspace.dart';

extension WSPresenter on Workspace {
  List<Source> get sortedSources => sources.sorted((s1, s2) => s1.url.compareTo(s2.url));
}
