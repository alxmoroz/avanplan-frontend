// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';

class TaskDescriptionDialog extends StatelessWidget {
  const TaskDescriptionDialog(this.teController);

  final TextEditingController teController;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: loc.description),
      body: Builder(
        builder: (ctx) => MTTextField(
          controller: teController,
          margin: MediaQuery.paddingOf(ctx).copyWith(left: P2, right: P2),
          maxLines: 10,
        ),
      ),
    );
  }
}
