// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../main.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_constrained.dart';
import '../../../components/mt_limit_badge.dart';
import '../../../presenters/task_level_presenter.dart';
import '../task_view_controller.dart';

class TaskAddButton extends StatelessWidget {
  const TaskAddButton(this.controller, {this.compact = false, this.dismissible = false});
  final TaskViewController controller;
  final bool compact;
  final bool dismissible;

  Widget get _plusIcon => const PlusIcon(color: lightBackgroundColor);

  Future _tap() async {
    if (dismissible) {
      Navigator.of(rootKey.currentContext!).pop();
    }
    await controller.addSubtask();
  }

  @override
  Widget build(BuildContext context) {
    final badge = MTLimitBadge(
      child: MTButton.main(
        leading: compact ? null : _plusIcon,
        titleText: compact ? null : controller.task.newSubtaskTitle,
        middle: compact ? _plusIcon : null,
        constrained: false,
        onTap: _tap,
        margin: EdgeInsets.only(right: compact ? P : 0),
      ),
      showBadge: !controller.plCreate,
    );

    return compact ? badge : MTAdaptive.S(badge);
  }
}
