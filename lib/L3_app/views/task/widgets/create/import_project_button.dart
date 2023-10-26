// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../extra/services.dart';
import '../../controllers/create_project_controller.dart';

class ImportProjectButton extends StatelessWidget {
  const ImportProjectButton(
    this._controller, {
    bool compact = false,
    bool secondary = false,
  })  : _compact = compact,
        _secondary = secondary;

  final bool _compact;
  final bool _secondary;
  final CreateProjectController _controller;

  Widget get _icon => ImportIcon(color: _secondary ? mainColor : mainBtnTitleColor, size: P4);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTBadgeButton(
        margin: EdgeInsets.only(right: _compact ? P2 : 0),
        showBadge: _controller.showPayBadge,
        type: _secondary ? ButtonType.secondary : ButtonType.main,
        leading: _compact ? null : _icon,
        titleText: _compact ? null : loc.import_action_title,
        middle: _compact ? _icon : null,
        constrained: !_compact,
        onTap: _controller.startImport,
      ),
    );
  }
}
