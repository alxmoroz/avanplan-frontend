// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/workspace.dart';
import '../../../components/adaptive.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/limit_badge.dart';
import '../../../presenters/task_type.dart';
import '../controllers/create_controller.dart';
import '../controllers/task_controller.dart';

class TaskCreateButton extends StatelessWidget {
  TaskCreateButton(
    Workspace _ws, {
    TaskController? parentTaskController,
    bool compact = false,
    bool dismissible = false,
  })  : _controller = CreateController(_ws, parentTaskController),
        _compact = compact,
        _dismissible = dismissible;

  final CreateController _controller;
  final bool _compact;
  final bool _dismissible;

  Widget get _plusIcon => const PlusIcon(color: mainBtnTitleColor);

  @override
  Widget build(BuildContext context) {
    Future _tap() async {
      if (_dismissible && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      await _controller.create();
    }

    final badge = MTLimitBadge(
      margin: EdgeInsets.only(right: _compact ? P3 : 0),
      showBadge: !_controller.plCreate,
      child: MTButton.main(
        leading: _compact ? null : _plusIcon,
        titleText: _compact ? null : newSubtaskTitle(_controller.parent),
        middle: _compact ? _plusIcon : null,
        constrained: false,
        onTap: _tap,
      ),
    );

    return _compact ? badge : MTAdaptive.XS(child: badge);
  }
}
