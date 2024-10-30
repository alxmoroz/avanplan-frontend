// Copyright (c) 2024. Alexandr Moroz

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_relation.dart';
import '../../../extra/services.dart';
import '../controllers/relations_controller.dart';
import '../widgets/relations/create_relation_dialog.dart';

extension ProjectModulesUC on RelationsController {
  void startCreateRelation() => createRelationDialog(tc);

  Future reloadRelatedTasks() async {
    await load(() async {
      final forbiddenTasksCount = await tasksMainController.loadTasksIfAbsent(wsId, relatedTasksIds);
      setForbiddenRelatedTasksCount(forbiddenTasksCount);
      reload();
    });
  }

  Future deleteRelationFromTask(Task dst) async {
    final r = task.relationOfTask(dst.id!);
    if (r != null) {
      final relation = await relationsUC.deleteRelation(r);
      if (relation != null) {
        task.relations.remove(relation);
        reload();
        dst.relations.remove(relation);
      }
    }
  }
}
