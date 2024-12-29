// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/images.dart';
import '../../components/text.dart';
import '../app/services.dart';
import 'create_project_button.dart';
import 'create_project_controller.dart';

class NoProjects extends StatelessWidget {
  const NoProjects(this._controller, {super.key});
  final CreateProjectController _controller;

  bool get _isAllProjectsClosed => tasksMainController.isAllProjectsClosed;

  Future _tapShowClosed(BuildContext context) async => _controller.setShowClosedProjects();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: P12),
          MTImage((_isAllProjectsClosed ? ImageName.ok : ImageName.empty_tasks).name),
          const SizedBox(height: P3),
          if (_isAllProjectsClosed)
            MTButton(
              leading: H2(loc.project_list_title, color: mainColor, maxLines: 1),
              middle: H2(loc.are_closed_suffix, maxLines: 1),
              onTap: () => _tapShowClosed(context),
            )
          else
            H2(
              loc.project_list_empty_title,
              align: TextAlign.center,
              padding: const EdgeInsets.all(P3),
            ),
          BaseText(
            loc.project_list_empty_hint,
            align: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: P6),
          ),
          const SizedBox(height: P3),
          CreateProjectButton(_controller, type: MTButtonType.main),
        ],
      ),
    );
  }
}
