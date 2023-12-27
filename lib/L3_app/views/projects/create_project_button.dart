// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../presenters/task_type.dart';
import 'create_project_controller.dart';

class CreateProjectButton extends StatelessWidget {
  const CreateProjectButton(
    this._controller, {
    this.compact = false,
    this.type,
  });
  final CreateProjectController _controller;
  final bool compact;
  final ButtonType? type;

  Widget get _plusIcon => PlusIcon(
        color: type == ButtonType.main ? mainBtnTitleColor : mainColor,
        size: type != null ? P4 : P6,
        circled: isBigScreen && type == null,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => isBigScreen && type == null
          ? MTListTile(
              leading: Stack(
                alignment: Alignment.topCenter,
                children: [
                  _plusIcon,
                  if (_controller.mustPay)
                    Container(
                      padding: const EdgeInsets.only(right: P * 5 - 2, top: 2),
                      child: const RoubleCircleIcon(size: P2),
                    ),
                ],
              ),
              middle: !compact ? BaseText(addSubtaskActionTitle(null), maxLines: 1, color: mainColor) : null,
              bottomDivider: false,
              onTap: _controller.startCreate,
            )
          : MTBadgeButton(
              margin: EdgeInsets.only(right: compact ? P2 : 0),
              showBadge: _controller.mustPay,
              type: type ?? ButtonType.main,
              leading: compact ? null : _plusIcon,
              titleText: compact ? null : addSubtaskActionTitle(null),
              middle: compact ? _plusIcon : null,
              constrained: !compact,
              onTap: _controller.startCreate,
            ),
    );
  }
}
