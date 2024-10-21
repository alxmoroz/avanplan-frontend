// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';
import '../details/task_description_field.dart';

Future showWikiMainPageDialog(TaskController controller) async => await showMTDialog(_WikiMainPageDialog(controller), maxWidth: SCR_M_WIDTH);

class _WikiMainPageDialog extends StatelessWidget {
  const _WikiMainPageDialog(this._controller);
  final TaskController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.description, parentPageTitle: _controller.task.title),
      body: SafeArea(
        bottom: false,
        minimum: const EdgeInsets.only(bottom: P3),
        child: ListView(
          shrinkWrap: true,
          children: [
            TaskDescriptionField(_controller, standalone: true, padding: const EdgeInsets.symmetric(horizontal: P3)),
          ],
        ),
      ),
    );
  }
}
