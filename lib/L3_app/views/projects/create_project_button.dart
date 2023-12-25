// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../presenters/task_type.dart';
import 'create_project_controller.dart';

class CreateProjectButton extends StatelessWidget {
  const CreateProjectButton(
    this._controller, {
    bool compact = false,
  }) : _compact = compact;

  final CreateProjectController _controller;
  final bool _compact;

  static const _type = ButtonType.secondary;

  Widget get _plusIcon => PlusIcon(
        color: _type == ButtonType.secondary ? mainColor : mainBtnTitleColor,
        size: _compact ? P5 : P4,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTBadgeButton(
        margin: EdgeInsets.only(right: _compact ? P2 : 0),
        showBadge: _controller.mustPay,
        type: _type,
        leading: _compact ? null : _plusIcon,
        titleText: _compact ? null : addSubtaskActionTitle(null),
        middle: _compact ? _plusIcon : null,
        constrained: !_compact,
        onTap: () => _controller.startCreate(),
      ),
    );
  }
}
