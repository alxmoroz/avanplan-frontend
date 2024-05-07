// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';

Future showTask404Dialog() async => await showMTDialog<void>(const _TaskNotFoundDialog());

class _TaskNotFoundDialog extends StatelessWidget {
  const _TaskNotFoundDialog();

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: const MTAppBar(showCloseButton: true, color: b2Color),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTImage(ImageName.no_info.name),
          const SizedBox(height: P3),
          H2(loc.error_404_task_title, align: TextAlign.center),
          const SizedBox(height: P),
          BaseText(loc.error_404_task_description, align: TextAlign.center),
          const SizedBox(height: P3),
        ],
      ),
    );
  }
}
