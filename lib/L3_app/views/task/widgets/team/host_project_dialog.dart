// Copyright (c) 2024. Alexandr Moroz

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/alert_dialog.dart';
import '../../../../components/button.dart';
import '../../../../components/images.dart';
import '../../../../extra/services.dart';
import '../../../../navigation/router.dart';

Future startWithHostProjectDialog(TaskDescriptor hostProject) async {
  await showMTAlertDialog(
    imageName: ImageName.team.name,
    title: loc.start_with_host_project_dialog_title,
    description: loc.start_with_host_project_dialog_description(hostProject.title),
    actions: [
      MTDialogAction(
        title: loc.start_with_host_project_action_title,
        type: ButtonType.main,
        onTap: () => router.goTask(hostProject),
      ),
      MTDialogAction(title: loc.later, type: ButtonType.text),
    ],
  );
}
