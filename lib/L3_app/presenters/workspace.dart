// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/estimate_value.dart';
import '../../L1_domain/entities/remote_source.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';

extension WSPresenter on Workspace {
  List<RemoteSource> get sortedSources => sources.sorted((s1, s2) => s1.url.compareTo(s2.url));
  List<User> get sortedUsers => users.sorted((u1, u2) => compareNatural('$u1', '$u2'));
  List<EstimateValue> get sortedEstimateValues => estimateValues.sortedBy<num>((e) => e.value);

  String get wsUsersStr => sortedUsers.map((u) => u.viewableName).take(1).join(', ');
  String get wsUsersCountMoreStr => sortedUsers.length > 1 ? loc.more_count(users.length - 1) : '';

  String get estimateUnitCode => '${settings?.estimateUnit ?? ''}';

  String get codeStr => wsMainController.multiWS ? code : '';
}
