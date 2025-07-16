// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../presenters/task_type.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import 'creation_dialog.dart';

class CreateProjectButton extends StatelessWidget {
  const CreateProjectButton({super.key, this.compact = false, this.type});
  final bool compact;
  final MTButtonType? type;

  Widget _plusIcon(BuildContext context) => PlusIcon(
        color: type == MTButtonType.main ? mainBtnTitleColor : mainColor,
        size: type != null ? P4 : DEF_TAPPABLE_ICON_SIZE,
        circled: canShowVerticalBars(context) && type == null,
      );

  @override
  Widget build(BuildContext context) {
    final plusIcon = _plusIcon(context);
    final title = addTaskActionTitle(TType.PROJECT);
    return canShowVerticalBars(context) && type == null
        ? MTListTile(
            color: b3Color,
            leading: plusIcon,
            middle: !compact ? BaseText(title, maxLines: 1, color: mainColor) : null,
            onTap: ProjectCreationDialog.startCreateProject,
          )
        : MTButton(
            margin: EdgeInsets.only(right: compact ? P2 : 0),
            type: type ?? MTButtonType.main,
            leading: compact ? null : plusIcon,
            titleText: compact ? null : title,
            middle: compact ? plusIcon : null,
            constrained: !compact,
            onTap: ProjectCreationDialog.startCreateProject,
          );
  }
}
