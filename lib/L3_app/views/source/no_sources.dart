// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../views/source/source_edit_dialog.dart';

class NoSources extends StatelessWidget {
  const NoSources(this._ws, {super.key});
  final Workspace _ws;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: P3),
        MTImage(ImageName.empty_sources.name),
        H2(loc.source_list_empty_title, align: TextAlign.center, padding: const EdgeInsets.all(P3)),
        BaseText(loc.source_list_empty_hint, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P6)),
        MTButton.main(
          leading: const PlusIcon(color: mainBtnTitleColor),
          titleText: loc.source_create_action_title,
          margin: EdgeInsets.only(top: P3, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
          onTap: () => startAddSource(_ws),
        ),
      ],
    );
  }
}
