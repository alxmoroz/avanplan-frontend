// Copyright (c) 2024. Alexandr Moroz

import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';

enum _FileSource { gallery, camera, files }

Future editAvatarDialog() async => await showMTDialog<void>(_EditAvatarDialog());

class _EditAvatarDialog extends StatelessWidget {
  Future _upload(BuildContext context, _FileSource fSource) async {
    Navigator.of(context).pop();

    XFile? file;

    if (fSource == _FileSource.files) {
      file = await openFile();
    } else if (fSource == _FileSource.gallery) {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else if (fSource == _FileSource.camera) {
      file = await ImagePicker().pickImage(source: ImageSource.camera);
    }

    if (file != null) {
      await accountController.uploadAvatar(file);
    }
  }

  Future _deleteAvatar(BuildContext context) async {
    Navigator.of(context).pop();
    await accountController.deleteAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(color: b2Color, showCloseButton: true, title: loc.avatar_edit_action_title),
      body: Builder(
        builder: (context) => ListView(
          shrinkWrap: true,
          children: [
            if (!isWeb)
              MTListTile(
                leading: MimeTypeIcon('image'),
                middle: BaseText(loc.file_source_gallery_title, color: mainColor),
                dividerIndent: P11,
                onTap: () => _upload(context, _FileSource.gallery),
              ),
            MTListTile(
              leading: const ProjectsIcon(color: mainColor),
              middle: BaseText(loc.file_source_files_title, color: mainColor),
              dividerIndent: P11,
              bottomDivider: !isWeb,
              onTap: () => _upload(context, _FileSource.files),
            ),
            if (!isWeb)
              MTListTile(
                leading: const CameraIcon(),
                middle: BaseText(loc.file_source_camera_title, color: mainColor),
                bottomDivider: false,
                onTap: () => _upload(context, _FileSource.camera),
              ),
            if (accountController.me!.hasAvatar)
              MTListTile(
                leading: const DeleteIcon(size: P6),
                middle: BaseText(loc.action_delete_title, color: dangerColor),
                margin: const EdgeInsets.only(top: P3),
                bottomDivider: false,
                onTap: () => _deleteAvatar(context),
              ),
          ],
        ),
      ),
    );
  }
}
