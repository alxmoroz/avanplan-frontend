// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/adaptive.dart';
import '../../../components/button.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/limit_badge.dart';
import '../../../presenters/task_type.dart';
import '../controllers/create_controller.dart';

class TaskCreateButton extends StatelessWidget {
  const TaskCreateButton(this.controller, {this.compact = false, this.dismissible = false});
  final CreateController controller;
  final bool compact;
  final bool dismissible;

  Widget get _plusIcon => const PlusIcon(color: mainBtnTitleColor);

  @override
  Widget build(BuildContext context) {
    Future _tap() async {
      if (dismissible && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      await controller.create();
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
