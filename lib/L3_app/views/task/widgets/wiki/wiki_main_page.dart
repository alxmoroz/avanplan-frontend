// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/task_controller.dart';
import '../details/task_description_field.dart';

Future showWikiMainPageDialog(TaskController controller) async => await showMTDialog(_WikiMainPageDialog(controller), maxWidth: SCR_M_WIDTH);

class _WikiMainPageDialog extends StatelessWidget {
  const _WikiMainPageDialog(this._controller);
  final TaskController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, middle: _controller.task.subPageTitle(loc.description), color: b2Color),
      body: SafeArea(
        bottom: false,
        minimum: const EdgeInsets.only(bottom: P3),
        child: ListView(
          padding: MediaQuery.paddingOf(context).add(const EdgeInsets.symmetric(horizontal: P3)),
          shrinkWrap: true,
          children: [
            TaskDescriptionField(_controller, standalone: true),
          ],
        ),
      ),
    );
  }
}
