// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';

class SourceTypeSelector extends StatelessWidget {
  const SourceTypeSelector(this.onTap);
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P),
          NormalText(loc.projects_add_select_st_title),
          const SizedBox(height: P),
          ListView.builder(
            shrinkWrap: true,
            itemCount: refsController.sourceTypes.length,
            itemBuilder: (_, index) {
              final st = refsController.sourceTypes[index];
              return MTListTile(
                middle: iconTitleForSourceType(st),
                trailing: const ChevronIcon(),
                bottomBorder: index < refsController.sourceTypes.length - 1,
                onTap: () => onTap(st),
              );
            },
          ),
          const SizedBox(height: P),
        ],
      );
}
