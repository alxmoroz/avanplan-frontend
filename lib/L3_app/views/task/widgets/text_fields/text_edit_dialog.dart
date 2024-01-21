// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L2_data/services/platform.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../controllers/task_controller.dart';

class TextEditDialog extends StatelessWidget {
  const TextEditDialog(this._controller, this._fCode, this._title, {super.key});
  final TaskController _controller;
  final TaskFCode _fCode;
  final String _title;

  MTFieldData get _fd => _controller.fData(_fCode.index);
  TextEditingController get _tc => _controller.teController(_fCode.index)!;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: _title),
      body: Observer(
        builder: (ctx) {
          final mqPadding = MediaQuery.paddingOf(ctx);
          return Padding(
            padding: mqPadding.add(EdgeInsets.only(bottom: mqPadding.bottom == 0 ? P3 : 0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: P2),
                Expanded(
                  child: MTTextField(
                    controller: _tc,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(horizontal: P2, vertical: P2 * (isWeb ? 1.35 : 1)),
                    maxLines: 20,
                  ),
                ),
                MTButton.main(
                  elevation: 0,
                  constrained: false,
                  minSize: const Size(P6, P6),
                  middle: const SubmitIcon(color: mainBtnTitleColor),
                  margin: const EdgeInsets.only(left: P2, right: P2, bottom: P),
                  onTap: _fd.text.trim().isNotEmpty ? () => Navigator.of(context).pop(true) : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
