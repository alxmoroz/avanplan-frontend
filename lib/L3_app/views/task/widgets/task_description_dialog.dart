// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/components/mt_toolbar.dart';
import 'package:flutter/cupertino.dart';

import '../../../components/constants.dart';
import '../../../components/mt_dialog.dart';
import '../../../components/mt_text_field.dart';
import '../../../extra/services.dart';

class TaskDescriptionDialog extends StatelessWidget {
  const TaskDescriptionDialog(this.teController);

  final TextEditingController teController;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: loc.description),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTTextField(
            controller: teController,
            margin: const EdgeInsets.symmetric(horizontal: P),
          ),
        ],
      ),
    );
  }
}
