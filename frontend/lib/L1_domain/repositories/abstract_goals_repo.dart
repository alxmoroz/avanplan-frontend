// Copyright (c) 2022. Alexandr Moroz

import '../entities/goal.dart';

abstract class AbstractGoalsRepo {
  Future<List<Goal>> getGoals();
}
