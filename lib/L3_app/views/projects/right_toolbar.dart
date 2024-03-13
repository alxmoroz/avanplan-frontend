// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/vertical_toolbar.dart';
import '../../components/vertical_toolbar_controller.dart';
import 'create_project_button.dart';
import 'create_project_controller.dart';

class ProjectsRightToolbar extends StatelessWidget implements PreferredSizeWidget {
  const ProjectsRightToolbar(this._controller, {super.key});
  final VerticalToolbarController _controller;

  @override
  Size get preferredSize => Size.fromWidth(_controller.width);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => VerticalToolbar(
        _controller,
        child: Column(
          children: [
            const Spacer(),
            CreateProjectButton(CreateProjectController(), compact: _controller.compact),
          ],
        ),
      ),
    );
  }
}
