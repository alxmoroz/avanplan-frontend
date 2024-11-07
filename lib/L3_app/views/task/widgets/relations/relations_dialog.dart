// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../navigation/router.dart';
import '../../../_base/loader_screen.dart';
import '../../controllers/relations_controller.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/relations.dart';
import '../tasks/tasks_list_view.dart';
import 'related_task_preview.dart';

Future relationsDialog(RelationsController rc) async {
  rc.reloadRelatedTasks();
  await showMTDialog(_RelationsDialog(rc));
}

class _RelationsDialog extends StatelessWidget {
  const _RelationsDialog(this._rc);
  final RelationsController _rc;

  Future _showTask(BuildContext context, Task t) async {
    // превью для мобилки, чтобы не делать бесконечную пуш-навигацию
    // выход из превью может сопровождаться желанием перейти к задаче для редактирования
    // для большого экрана не показываем превью, переходим к целевой задаче
    final big = isBigScreen(context);
    // есть желание и возможность перейти к целевой задаче
    if (big || await showMTDialog(RelatedTaskPreview(TaskController(taskIn: t, isPreview: true))) == true) {
      // закрываем этот диалог (список связей)
      if (context.mounted) Navigator.of(context).pop();

      // Переходим к целевой задаче
      router.goTaskSameRoute(t, _rc.task);
    }
  }

  bool get _onlyOneTaskInWS => tasksMainController.tasks.where((t) => t.wsId == _rc.wsId).length == 1;

  Widget get _createRelationButton => MTButton.secondary(
        leading: const PlusIcon(),
        titleText: '${loc.action_add_title} ${loc.relation_title.toLowerCase()}',
        onTap: _rc.startCreateRelation,
      );

  Widget get _emptyRelationsScreen => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MTImage(ImageName.relations.name),
          H2(
            _onlyOneTaskInWS ? loc.relations_only_one_task_title : loc.relations_empty_title,
            padding: const EdgeInsets.all(P3),
            align: TextAlign.center,
          ),
          if (!_onlyOneTaskInWS) ...[
            BaseText(loc.relations_empty_hint, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P6)),
            const SizedBox(height: P3),
            _createRelationButton,
          ],
        ],
      );

  Widget _tasksDialog(BuildContext context) {
    final forbiddenCount = _rc.forbiddenRelatedTasksCount;
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.relations_title, parentPageTitle: _rc.task.title),
      body: _rc.hasRelations
          ? TasksListView(
              _rc.availableTasksGroups,
              parent: _rc.task,
              adaptive: false,
              extra: forbiddenCount > 0
                  ? SmallText(
                      '${loc.more_count(forbiddenCount)} ${loc.task_plural(forbiddenCount)} ${loc.tasks_forbidden_view_suffix(forbiddenCount)}',
                      padding: const EdgeInsets.symmetric(horizontal: P3, vertical: P),
                      align: TextAlign.center,
                    )
                  : null,
              delIconData: const LinkOffIcon().iconData,
              deleteActionLabel: loc.action_unlink_title,
              onTaskTap: (t) => _showTask(context, t),
              onTaskDelete: _rc.deleteRelationFromTask,
            )
          : _emptyRelationsScreen,
      forceBottomPadding: !_rc.hasRelations && !_onlyOneTaskInWS,
      bottomBar: _rc.hasRelations
          ? MTBottomBar(
              middle: _onlyOneTaskInWS
                  ? SmallText(loc.relations_only_one_task_title, padding: const EdgeInsets.symmetric(horizontal: P3), align: TextAlign.center)
                  : _createRelationButton)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _rc.loading ? LoaderScreen(_rc, isDialog: true) : _tasksDialog(context),
    );
  }
}
