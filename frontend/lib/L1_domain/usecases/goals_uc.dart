// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/goal.dart';
import '../entities/goals/task.dart';
import '../repositories/abstract_goals_repo.dart';
import '../repositories/abstract_tasks_repo.dart';

class GoalsUC {
  GoalsUC({
    required this.gRepo,
    required this.tRepo,
  });

  final AbstractGoalsRepo gRepo;
  final AbstractTasksRepo tRepo;

  Future<List<Goal>> getGoals() async {
    final goals = await gRepo.getGoals();
    _sortGoals(goals);
    return goals;
  }

  void _sortGoals(List<Goal> goals) {
    goals.sort((g1, g2) => g1.title.compareTo(g2.title));
  }

  Future<Goal?> saveGoal({
    required int? id,
    required String title,
    required String description,
    required DateTime? dueDate,
    required List<Goal> goals,
  }) async {
    Goal? goal;
    // TODO: внутр. exception?
    if (title.trim().isNotEmpty && dueDate != null) {
      goal = await gRepo.saveGoal(id: id, title: title, description: description, dueDate: dueDate);

      if (goal != null) {
        final index = goals.indexWhere((g) => g.id == id);
        if (index >= 0) {
          goals[index] = goal;
        } else {
          goals.add(goal);
        }
        _sortGoals(goals);
      }
    }
    return goal;
  }

  Future<Goal?> deleteGoal({required Goal goal, required List<Goal> goals}) async {
    final deletedRows = await gRepo.deleteGoal(goal.id);
    // TODO: внутр. exception?
    if (deletedRows) {
      goal.deleted = true;
      goals.remove(goal);
      _sortGoals(goals);
    }
    return goal;
  }

  Future<Task?> saveTask({
    required Goal goal,
    required int? id,
    required int? parentId,
    required String title,
    required String description,
    required DateTime? dueDate,
  }) async {
    Task? task;
    // TODO: внутр. exception?
    if (title.trim().isNotEmpty) {
      task = await tRepo.saveTask(goalId: goal.id, id: id, parentId: parentId, title: title, description: description, dueDate: dueDate);

      if (task != null) {
        final index = goal.tasks.indexWhere((t) => t.id == id);
        if (index >= 0) {
          goal.tasks[index] = task;
        } else {
          goal.tasks.add(task);
        }
      }
    }
    return task;
  }

  Future<Task?> deleteTask({required Goal goal, required Task task}) async {
    final deletedRows = await tRepo.deleteTask(task.id);
    // TODO: внутр. exception?
    if (deletedRows) {
      task.deleted = true;
      goal.tasks.remove(task);
    }
    return task;
  }
}
