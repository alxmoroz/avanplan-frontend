// Copyright (c) 2024. Alexandr Moroz

import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/icons_workspace.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/attachments_controller.dart';

enum _FileSource { gallery, files }

Future<List<XFile>> selectFilesDialog() async {
  List<XFile> files = [];

  final type = kIsWeb
      ? _FileSource.files
      : await showMTDialog<_FileSource?>(
          MTDialog(
            topBar: MTAppBar(
              color: b2Color,
              showCloseButton: true,
              title: loc.attachment_source_selector_title,
            ),
            body: Builder(
              builder: (context) => ListView(
                shrinkWrap: true,
                children: [
                  MTListTile(
                    leading: MimeTypeIcon('image'),
                    titleText: loc.attachment_source_gallery_title,
                    dividerIndent: P6 + P5,
                    onTap: () => Navigator.of(context).pop(_FileSource.gallery),
                  ),
                  MTListTile(
                    leading: const ProjectsIcon(color: mainColor),
                    titleText: loc.attachment_source_files_title,
                    bottomDivider: false,
                    onTap: () => Navigator.of(context).pop(_FileSource.files),
                  ),
                ],
              ),
            ),
          ),
        );
  if (type != null) {
    if (type == _FileSource.files) {
      files = await openFiles();
    } else {
      files = await ImagePicker().pickMultipleMedia();
    }
  }

  return files;
}

class UploadDetails extends StatelessWidget {
  const UploadDetails(this._controller, {super.key});

  final AttachmentsController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: P2).copyWith(top: P),
      child: Row(
        children: [
          Flexible(child: SmallText(_controller.selectedFilesStr, maxLines: 1)),
          if (_controller.selectedFilesCountMoreStr.isNotEmpty)
            SmallText(
              _controller.selectedFilesCountMoreStr,
              maxLines: 1,
              padding: const EdgeInsets.only(left: P),
            ),
        ],
      ),
    );
  }
}
