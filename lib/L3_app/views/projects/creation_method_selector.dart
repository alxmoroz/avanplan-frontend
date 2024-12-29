// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../app/services.dart';

Future<CreationMethod?> selectProjectCreationMethod() async => await showMTDialog<CreationMethod?>(const _ProjectCreationMethodDialog());

enum CreationMethod { create, template, import }

class _ProjectCreationMethodDialog extends StatelessWidget {
  const _ProjectCreationMethodDialog();

  static const _dividerIndent = P5 + DEF_TAPPABLE_ICON_SIZE;
  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.project_creation_method_selector_title),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTListTile(
            leading: const PlusIcon(size: DEF_TAPPABLE_ICON_SIZE, circled: true),
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
