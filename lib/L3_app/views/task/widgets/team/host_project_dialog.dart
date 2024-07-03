// Copyright (c) 2024. Alexandr Moroz

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/alert_dialog.dart';
import '../../../../components/button.dart';
import '../../../../components/images.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';

Future startWithHostProjectDialog(TaskDescriptor hostProject) async {
  await showMTAlertDialog(
    loc.start_with_host_project_dialog_title,
    imageName: ImageName.team.name,
    description: loc.start_with_host_project_dialog_description(hostProject.title),
    actions: [
      MTDialogAction(title: loc.later),
      MTDialogAction(
        title: loc.start_with_host_project_action_title,
        type: ButtonType.main,
        onTap: () => router.goTaskView(hostProject),
      ),
    ],
  );
}
