// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/limit_badge.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/ws_actions.dart';
import '../../controllers/create_controller.dart';

class ProjectCreateButton extends StatelessWidget {
  const ProjectCreateButton(
    this._controller, {
    bool compact = false,
  }) : _compact = compact;

  final CreateController _controller;
  final bool _compact;
  Workspace? get _ws => _controller.ws;

  Widget get _plusIcon => const PlusIcon(color: mainBtnTitleColor);

  Widget _btn(BuildContext context) => MTLimitBadge(
        margin: EdgeInsets.only(right: _compact ? P3 : 0),
        showBadge: !_controller.mustSelectWS && !_ws!.plCreate(null),
        child: MTButton.main(
          leading: _compact ? null : _plusIcon,
          titleText: _compact ? null : addSubtaskActionTitle(null),
          middle: _compact ? _plusIcon : null,
          constrained: false,
          onTap: () => _controller.createProject(context),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _compact ? _btn(context) : MTAdaptive.xxs(child: _btn(context)),
    );
  }
}
