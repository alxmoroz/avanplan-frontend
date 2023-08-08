// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_limit_badge.dart';
import '../../../presenters/task_type_presenter.dart';
import '../task_add_controller.dart';

class TaskAddButton extends StatelessWidget {
  const TaskAddButton(this.controller, {this.compact = false, this.dismissible = false});
  final TaskAddController controller;
  final bool compact;
  final bool dismissible;

  Widget get _plusIcon => const PlusIcon(color: lightBackgroundColor);

  @override
  Widget build(BuildContext context) {
    Future _tap() async {
      if (dismissible && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      await controller.addSubtask();
    }

    final badge = MTLimitBadge(
      child: MTButton.main(
        leading: compact ? null : _plusIcon,
        titleText: compact ? null : newSubtaskTitle(controller.parent?.type ?? TType.ROOT),
        middle: compact ? _plusIcon : null,
        constrained: false,
        onTap: _tap,
        margin: EdgeInsets.only(right: compact ? P : 0),
      ),
      showBadge: !controller.plCreate,
    );

    return compact ? badge : MTAdaptive.XS(badge);
  }
}
