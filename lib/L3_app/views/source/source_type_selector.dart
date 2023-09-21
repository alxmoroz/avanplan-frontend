// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/source_type.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';

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
              leading: st.icon(size: P5),
              middle: BaseText(st.title),
              trailing: const ChevronIcon(),
              bottomDivider: index < refsController.sourceTypes.length - 1,
              onTap: () => onTap(st),
            );
          },
        ),
      );
}
