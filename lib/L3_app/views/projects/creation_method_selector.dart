// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';

Future<CreationMethod?> selectCreationMethod() async => await showMTDialog<CreationMethod?>(CreationMethodSelector());

enum CreationMethod { create, template, import }

class CreationMethodSelector extends StatelessWidget {
  static const _dividerIndent = P10;
  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTToolBar(titleText: loc.project_creation_method_selector_title),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTListTile(
            leading: const PlusIcon(size: P5),
            titleText: loc.create_from_scratch_action_title,
            dividerIndent: _dividerIndent,
            subtitle: SmallText(loc.create_from_scratch_action_description),
            onTap: () => Navigator.of(context).pop(CreationMethod.create),
          ),
          MTListTile(
            leading: const TemplateIcon(),
            titleText: loc.create_from_template_action_title,
            dividerIndent: _dividerIndent,
            subtitle: SmallText(loc.create_from_template_action_description),
            onTap: () => Navigator.of(context).pop(CreationMethod.template),
          ),
          MTListTile(
            leading: const ImportIcon(),
            titleText: loc.import_action_title,
            dividerIndent: _dividerIndent,
            subtitle: SmallText(loc.import_action_description),
            bottomDivider: false,
            onTap: () => Navigator.of(context).pop(CreationMethod.import),
          ),
        ],
      ),
    );
  }
}
