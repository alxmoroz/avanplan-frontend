// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/toolbar_controller.dart';
import '../../components/vertical_toolbar.dart';
import 'create_project_button.dart';
import 'create_project_controller.dart';

class ProjectsRightToolbar extends StatelessWidget implements PreferredSizeWidget {
  const ProjectsRightToolbar(this._tbc, {super.key});
  final MTToolbarController _tbc;

  @override
  Size get preferredSize => Size.fromWidth(_tbc.width);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => VerticalToolbar(
        _tbc,
        child: Column(
          children: [
            const Spacer(),
            CreateProjectButton(CreateProjectController(), compact: _tbc.compact),
          ],
        ),
      ),
    );
  }
}
