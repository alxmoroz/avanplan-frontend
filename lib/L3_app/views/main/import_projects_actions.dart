// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/usecases/task_ext_state.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_card.dart';
import '../../components/mt_constrained.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../usecases/task_ext_actions.dart';

class ImportProjectsActions extends StatelessWidget {
  const ImportProjectsActions(this.task);
  final Task task;

  @override
  Widget build(BuildContext context) => refsController.sourceTypes.isNotEmpty && task.canImport
      ? ListView(shrinkWrap: true, children: [
          Center(child: StartIcon(size: MediaQuery.of(context).size.height / 5)),
          const SizedBox(height: P2),
          H3(
            task.hasSubtasks ? loc.import_action_closed_projects_title : loc.import_action_no_projects_title,
            align: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: P2),
            maxLines: 5,
          ),
          const SizedBox(height: P),
          for (final st in refsController.sourceTypes)
            MTConstrained(
              MTCardButton(
                onTap: () => importController.importTasks(sType: st),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  iconForSourceType(st),
                  const SizedBox(width: P_2),
                  H4('$st'),
                ]),
              ),
            )
        ])
      : Center(child: H4(loc.project_count(0)));
}
