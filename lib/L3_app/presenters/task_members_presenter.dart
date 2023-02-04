// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/entities/task.dart';

extension TaskMembersPresenter on Task {
  List<Member> get activeMembers => sortedMembers.where((m) => m.isActive).toList();
  List<Member> get sortedMembers => members.sorted((m1, m2) => compareNatural('$m1', '$m2'));
}
