// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/text_field.dart';
import '../../components/toolbar.dart';
import '../../views/_base/loader_screen.dart';
import '../app/services.dart';
import 'usecases/edit.dart';
import 'ws_controller.dart';

Future showWSEditDialog(WSController controller) async {
  controller.setupFields();
  await showMTDialog<Workspace?>(_WSEditDialog(controller));
}

class _WSEditDialog extends StatelessWidget {
  const _WSEditDialog(this._controller);
  final WSController _controller;

  bool get canSave => _controller.validated;

  Widget _tf(WSFCode code) {
    final fd = _controller.fData(code.index);

    return MTTextField(
      controller: _controller.teController(code.index),
      label: fd.label,
      margin: tfMargin.copyWith(top: code == WSFCode.code ? P : tfMargin.top),
    );
  }

  Future _save(BuildContext context) async {
    Navigator.of(context).pop();
    _controller.save();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _controller.loading
          ? LoaderScreen(_controller, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(pageTitle: loc.workspace_title),
              body: ListView(
                shrinkWrap: true,
                children: [
                  for (final code in [WSFCode.code, WSFCode.title, WSFCode.description]) _tf(code),
                  MTButton.main(
                    titleText: loc.action_save_title,
                    margin: const EdgeInsets.only(top: P3),
                    onTap: canSave ? () => _save(context) : null,
                  ),
                ],
              ),
              forceBottomPadding: true,
              hasKBInput: true,
            ),
    );
  }
}
