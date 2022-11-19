// Copyright (c) 2022. Alexandr Moroz

import '../entities/user.dart';
import '../entities/workspace.dart';

abstract class AbstractApiMyRepo {
  Future<User?> getMyAccount();
  Future deleteMyAccount();
  Future<Iterable<Workspace>> getMyWorkspaces();
}
