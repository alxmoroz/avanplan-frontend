// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../components/mt_bottom_sheet.dart';
import '../../../components/text_widgets.dart';
import 'project_add_dialog_controller.dart';

Future addProjectDialog() async {
  return await showModalBottomSheet<void>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(ProjectAddMethodView()),
  );
}

class ProjectAddMethodView extends StatefulWidget {
  // нужен контроллер этого диалога, т.к. он многоступенчатый
  // либо делать несколько вьюх и пушить их внутри диалога, что мы раньше не делали вроде
  @override
  _ProjectAddMethodViewState createState() => _ProjectAddMethodViewState();
}

class _ProjectAddMethodViewState extends State<ProjectAddMethodView> {
  late final ProjectAddDialogController controller;

  @override
  void initState() {
    controller = ProjectAddDialogController();
    super.initState();
  }

  Widget get wsSelector => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          H4('ADD PROJECT'),
          // TaskAddButton(TaskViewController()),
        ],
      );

  @override
  Widget build(BuildContext context) => wsSelector;
}
