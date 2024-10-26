// Copyright (c) 2024. Alexandr Moroz

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
import '../../../../presenters/task_tree.dart';
import '../../../_base/loader_screen.dart';
import '../../controllers/relations_controller.dart';
import '../../controllers/task_controller.dart';
import '../tasks/task_preview.dart';
import '../tasks/tasks_list_view.dart';

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
    // обычный переход к задаче, без превью
    if (isBigScreen(context)) {
      router.goTaskView(t, direct: true);
    }
    // превью для мобилки, чтобы не делать бесконечную пуш-навигацию
    else {
      // выход из превью может сопровождаться желанием перейти к задаче для редактирования
      final wantGoTask = await showMTDialog(TaskPreview(TaskController(taskIn: t, isPreview: true)));
      if (wantGoTask == true) {
        // закрываем этот диалог (список связей)
        if (context.mounted) Navigator.of(context).pop();

        // Выходим из исходной задачи до проекта, если исходная и целевая в одном проекте
        // Иначе до главной - тогда и pop не нужен, просто директ переход
        bool direct = true;
        if (t.project == srcTask.project) {
          router.popToTaskTypeOrMain(TType.PROJECT);
          direct = false;
        }
        // переход к задаче по связи
        // здесь такой костыль, чтобы роутер успел обновить конфиг свой, если была тут же другая навигация
        await Future(() => router.goTaskView(t, direct: direct));
      }
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
