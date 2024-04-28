// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/attachment.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/bytes.dart';
import '../../controllers/attachments_controller.dart';

Future attachmentsDialog(AttachmentsController controller) async => await showMTDialog<void>(_AttachmentsDialog(controller));

class _AttachmentsDialog extends StatelessWidget {
  const _AttachmentsDialog(this._controller);
  final AttachmentsController _controller;

  Future _download(Attachment attachment) async {
    if (_controller.sortedAttachments.length < 2) router.pop();
    await _controller.download(attachment);
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.attachments_label),
      body: Observer(
        builder: (_) => MTShadowed(
          topPaddingIndent: 0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _controller.sortedAttachments.length,
            itemBuilder: (_, index) {
              final a = _controller.sortedAttachments[index];
              return MTListTile(
                leading: MimeTypeIcon(a.type),
                titleText: a.title,
                subtitle: SmallText(a.bytes.humanBytesStr, maxLines: 1),
                dividerIndent: P6 + P5,
                bottomDivider: index < _controller.sortedAttachments.length - 1,
                onTap: () => _download(a),
              );
            },
          ),
        ),
      ),
    );
  }
}
