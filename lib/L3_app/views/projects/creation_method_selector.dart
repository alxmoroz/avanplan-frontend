// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../presenters/task_create_method.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../app/services.dart';

Future<TaskCreationMethod?> selectProjectCreationMethod() async => await showMTDialog<TaskCreationMethod?>(const _ProjectCreationMethodDialog());

class _ProjectCreationMethodDialog extends StatelessWidget {
  const _ProjectCreationMethodDialog();

  static const _dividerIndent = P5 + DEF_TAPPABLE_ICON_SIZE;

  Widget _tileButton(BuildContext context, TaskCreationMethod method, bool bottomDivider) => MTListTile(
        color: b3Color,
        leading: method.btnIcon(),
        titleText: method.actionTitle,
        dividerIndent: _dividerIndent,
        subtitle: SmallText(method.actionDescription),
        bottomDivider: bottomDivider,
        onTap: () => Navigator.of(context).pop(method),
      );

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      body: ListView(
        shrinkWrap: true,
        children: [
          /// с нуля
          MTSectionTitle(loc.create_from_scratch_title, topMargin: 0),
          for (var m in [TaskCreationMethod.BOARD, TaskCreationMethod.LIST, TaskCreationMethod.PROJECT])
            _tileButton(context, m, m != TaskCreationMethod.PROJECT),

          /// готовые проекты (шаблон, импорт)
          MTSectionTitle(loc.create_from_ready_made),
          for (var m in [TaskCreationMethod.TEMPLATE, TaskCreationMethod.IMPORT]) _tileButton(context, m, m != TaskCreationMethod.IMPORT),
        ],
      ),
    );
  }
}
