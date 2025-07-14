// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/images.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../app/services.dart';
import 'create_project_button.dart';
import 'create_project_controller.dart';

class NoProjects extends StatelessWidget {
  const NoProjects(this._controller, {super.key});
  final CreateProjectController _controller;

  bool get _isAllProjectsClosed => tasksMainController.isAllProjectsClosed;

  Widget _showClosedProjectsButton(BuildContext context) {
    final h2TS = const H2('', maxLines: 1).style(context);
    final h2MainColorTS = h2TS.copyWith(color: mainColor.resolve(context));

    return MTButton(
      middle: RichText(
        text: TextSpan(children: [
          TextSpan(text: loc.project_list_title, style: h2MainColorTS),
          TextSpan(text: ' ${loc.are_closed_suffix}', style: h2TS),
        ]),
        textAlign: TextAlign.center,
      ),
      onTap: _controller.setShowClosedProjects,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: P12),
          MTImage((_isAllProjectsClosed ? ImageName.ok : ImageName.empty_tasks).name),
          if (_isAllProjectsClosed)
            _showClosedProjectsButton(context)
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
