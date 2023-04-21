// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';

class SourceTypeSelector extends StatelessWidget {
  const SourceTypeSelector(this.onTap);
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: P2),
          for (final st in refsController.sourceTypes)
            MTListTile(
              middle: iconTitleForSourceType(st),
              trailing: const ChevronIcon(),
              onTap: () => onTap(st),
            ),
          const SizedBox(height: P2),
        ],
      );
}
