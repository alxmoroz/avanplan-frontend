// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../app/services.dart';

Future<TaskCreationMethod?> selectProjectCreationMethod() async => await showMTDialog<TaskCreationMethod?>(const _ProjectCreationMethodDialog());

class _ProjectCreationMethodDialog extends StatelessWidget {
  const _ProjectCreationMethodDialog();

  static const _dividerIndent = P5 + DEF_TAPPABLE_ICON_SIZE;
  @override
  Widget build(BuildContext context) {
    return MTDialog(
      body: ListView(
        shrinkWrap: true,
        children: [
          MTListGroupTitle(titleText: loc.create_from_scratch_title, topMargin: 0),
          MTListTile(
            leading: const BoardIcon(size: DEF_TAPPABLE_ICON_SIZE),
            titleText: loc.tasks_view_mode_board,
            dividerIndent: _dividerIndent,
            subtitle: SmallText(loc.create_board_action_description),
            onTap: () => Navigator.of(context).pop(TaskCreationMethod.BOARD),
          ),
          MTListTile(
            leading: const ListIcon(size: DEF_TAPPABLE_ICON_SIZE),
            titleText: loc.tasks_view_mode_list,
            dividerIndent: _dividerIndent,
            subtitle: SmallText(loc.create_list_action_description),
            onTap: () => Navigator.of(context).pop(TaskCreationMethod.LIST),
          ),
          MTListTile(
            leading: const ProjectsIcon(size: DEF_TAPPABLE_ICON_SIZE),
            titleText: loc.project_title,
            bottomDivider: false,
            subtitle: SmallText(loc.create_project_action_description),
            onTap: () => Navigator.of(context).pop(TaskCreationMethod.PROJECT),
          ),

          /// готовые проекты (шаблон, импорт)
          MTListGroupTitle(titleText: loc.create_from_ready_made),
          MTListTile(
            leading: const TemplateIcon(),
            titleText: loc.create_from_template_action_title,
            dividerIndent: _dividerIndent,
            subtitle: SmallText(loc.create_from_template_action_description),
            onTap: () => Navigator.of(context).pop(TaskCreationMethod.TEMPLATE),
          ),
          MTListTile(
            leading: const ImportIcon(),
            titleText: loc.import_action_title,
            dividerIndent: _dividerIndent,
            subtitle: SmallText(loc.import_action_description),
            bottomDivider: false,
            onTap: () => Navigator.of(context).pop(TaskCreationMethod.IMPORT),
          ),
        ],
      ),
    );
  }
}
