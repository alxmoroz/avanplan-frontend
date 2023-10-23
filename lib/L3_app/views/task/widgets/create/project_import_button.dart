// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../extra/services.dart';
import '../../controllers/create_controller.dart';

class ProjectImportButton extends StatelessWidget {
  const ProjectImportButton(
    this._controller, {
    bool compact = false,
    bool secondary = false,
  })  : _compact = compact,
        _secondary = secondary;

  final bool _compact;
  final bool _secondary;
  final CreateController _controller;

  Widget get _icon => ImportIcon(color: _secondary ? mainColor : mainBtnTitleColor, size: P4);

  Widget _btn(BuildContext context) => MTButton(
        margin: EdgeInsets.only(right: _compact ? P2 : 0),
        type: _secondary ? ButtonType.secondary : ButtonType.main,
        leading: _compact ? null : _icon,
        titleText: _compact ? null : loc.import_action_title,
        middle: _compact ? _icon : null,
        constrained: false,
        onTap: _controller.startImport,
      );

  @override
  Widget build(BuildContext context) {
    return _compact ? _btn(context) : MTAdaptive.xxs(child: _btn(context));
  }
}
