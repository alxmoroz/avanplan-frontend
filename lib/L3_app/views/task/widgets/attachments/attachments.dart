// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/bytes.dart';
import '../../controllers/attachments_controller.dart';

class AttachmentsDialog extends StatelessWidget {
  const AttachmentsDialog(this._controller);
  final AttachmentsController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: loc.attachments_label),
      body: Observer(
        builder: (_) => MTShadowed(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _controller.sortedAttachments.length,
            itemBuilder: (_, index) {
              final a = _controller.sortedAttachments[index];
              return MTListTile(
                leading: MimeTypeIcon(mimeType: a.type),
                titleText: a.title,
                subtitle: SmallText(a.bytes.humanBytesStr, maxLines: 1),
                bottomDivider: index < _controller.sortedAttachments.length - 1,
                trailing: const DownloadIcon(),
                onTap: () => _controller.download(a),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future showAttachmentsDialog(AttachmentsController controller) async {
  await showMTDialog<void>(AttachmentsDialog(controller));
}
