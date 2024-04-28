// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';

Future<CreationMethod?> selectCreationMethod() async => await showMTDialog<CreationMethod?>(const _CreationMethodSelector());

enum CreationMethod { create, template, import }

class _CreationMethodSelector extends StatelessWidget {
  const _CreationMethodSelector();

  static const _dividerIndent = P11;
  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.project_creation_method_selector_title),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTListTile(
            leading: const PlusIcon(size: P6, circled: true),
            titleText: loc.create_from_scratch_action_title,
            dividerIndent: _dividerIndent,
            subtitle: SmallText(loc.create_from_scratch_action_description),
            onTap: () => router.pop(CreationMethod.create),
          ),
          MTListTile(
            leading: const TemplateIcon(),
            titleText: loc.create_from_template_action_title,
            dividerIndent: _dividerIndent,
            subtitle: SmallText(loc.create_from_template_action_description),
            onTap: () => router.pop(CreationMethod.template),
          ),
          MTListTile(
            leading: const ImportIcon(),
            titleText: loc.import_action_title,
            dividerIndent: _dividerIndent,
            subtitle: SmallText(loc.import_action_description),
            bottomDivider: false,
            onTap: () => router.pop(CreationMethod.import),
          ),
        ],
      ),
    );
  }
}
