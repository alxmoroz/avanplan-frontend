// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../navigation/router.dart';
import '../../../_base/loader_screen.dart';
import '../../controllers/relations_controller.dart';
import '../../controllers/task_controller.dart';
import '../tasks/tasks_list_view.dart';
import 'related_task_preview.dart';

Future relationsDialog(RelationsController rc) async {
  rc.reloadRelatedTasks();
  await showMTDialog(_RelationsDialog(rc));
}

class _RelationsDialog extends StatelessWidget {
  const _RelationsDialog(this._rc);
  final RelationsController _rc;

  void _addRelation() {
    print('ADD RELATION 1');
  }

  Future _showTask(BuildContext context, Task t, Task srcTask) async {
    // превью для мобилки, чтобы не делать бесконечную пуш-навигацию
    // выход из превью может сопровождаться желанием перейти к задаче для редактирования
    // для большого экрана не показываем превью, переходим к целевой задаче
    bool? wantGoTask = isBigScreen(context) || await showMTDialog(RelatedTaskPreview(TaskController(taskIn: t, isPreview: true)));
    // есть желание и возможность перейти к целевой задаче
    if (wantGoTask == true) {
      // закрываем этот диалог (список связей)
      if (context.mounted) Navigator.of(context).pop();

      // Переходим к целевой задаче
      router.goTaskFromTask(t, srcTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final srcTask = _rc.task;
        return _rc.loading
            ? LoaderScreen(_rc, isDialog: true)
            : MTDialog(
                topBar: MTTopBar(pageTitle: loc.task_relations_title, parentPageTitle: srcTask.title),
                body: _rc.hasRelations
                    ? TasksListView(
                        _rc.tasksGroups,
                        adaptive: false,
                        onTaskTap: (t) => _showTask(context, t, srcTask),
                      )
                    : ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          MTImage(ImageName.relations.name),
                          H2(loc.relations_empty_title, padding: const EdgeInsets.all(P3), align: TextAlign.center),
                          BaseText(loc.relations_empty_hint, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P6)),
                          const SizedBox(height: P3),
                        ],
                      ),
                bottomBar: MTBottomBar(middle: MTButton.main(titleText: loc.action_add_title, onTap: _addRelation)),
              );
      },
    );
  }
}
