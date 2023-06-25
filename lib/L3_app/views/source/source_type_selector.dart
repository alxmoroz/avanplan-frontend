// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/source_type.dart';
import '../../components/icons.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';

class SourceTypeSelector extends StatelessWidget {
  const SourceTypeSelector(this.onTap);
  final void Function(SourceType) onTap;

  @override
  Widget build(BuildContext context) => MTDialog(
        topBar: MTTopBar(titleText: loc.projects_add_select_st_title),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: refsController.sourceTypes.length,
          itemBuilder: (_, index) {
            final st = refsController.sourceTypes[index];
            return MTListTile(
              middle: iconTitleForSourceType(st),
              trailing: const ChevronIcon(),
              bottomDivider: index < refsController.sourceTypes.length - 1,
              onTap: () => onTap(st),
            );
          },
        ),
      );
}
