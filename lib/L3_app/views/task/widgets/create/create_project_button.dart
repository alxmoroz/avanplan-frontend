// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/create_project_controller.dart';

class CreateProjectButton extends StatelessWidget {
  const CreateProjectButton(
    this._controller, {
    bool compact = false,
  }) : _compact = compact;

  final CreateProjectController _controller;
  final bool _compact;

  Widget get _plusIcon => const PlusIcon(color: mainBtnTitleColor);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTBadgeButton(
        margin: EdgeInsets.only(right: _compact ? P3 : 0),
        showBadge: _controller.mustPay,
        type: ButtonType.main,
        leading: _compact ? null : _plusIcon,
        titleText: _compact ? null : addSubtaskActionTitle(null),
        middle: _compact ? _plusIcon : null,
        constrained: !_compact,
        onTap: () => _controller.startCreate(),
      ),
    );
  }
}
