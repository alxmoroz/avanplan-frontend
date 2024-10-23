// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../_base/loader_screen.dart';
import '../../controllers/relations_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _rc.loading
          ? LoaderScreen(_rc, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(pageTitle: loc.task_relations_title, parentPageTitle: _rc.task.title),
              body: _rc.hasRelations
                  ? TasksListView(
                      _rc.tasksGroups,
                      adaptive: false,
                      onTaskTap: (t) => print(t),
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
            ),
    );
  }
}
