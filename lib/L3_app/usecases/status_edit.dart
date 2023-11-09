// Copyright (c) 2023. Alexandr Moroz

import 'package:dio/dio.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/entities/project_status.dart';
import '../../L1_domain/entities/task.dart';
import '../../L2_data/services/api.dart';
import '../extra/services.dart';

extension StatusEditUC on ProjectStatus {
  Future<ProjectStatus?> edit(Future<ProjectStatus?> function()) async {
    loading = true;
    tasksMainController.refreshTasks();
    ProjectStatus? es;
    try {
      es = await function();
    } on DioException catch (e) {
      error = MTError(loader.titleText ?? '', description: loader.descriptionText, detail: e.detail);
    }
    loading = false;
    tasksMainController.refreshTasks();

    return es;
  }

  Future<ProjectStatus?> save(Task project) async => await edit(() async {
        final es = await projectStatusUC.save(this);
        if (es != null) {
          if (isNew) {
            project.projectStatuses.add(es);
          } else {
            final index = project.projectStatuses.indexWhere((s) => es.id == s.id);
            if (index > -1) {
              project.projectStatuses[index] = es;
            }
          }
          return es;
        }
        return null;
      });

  Future delete(Task project) async => await edit(() async {
        if (await projectStatusUC.delete(this) != null) {
          project.projectStatuses.remove(this);
        }
        return null;
      });
}
