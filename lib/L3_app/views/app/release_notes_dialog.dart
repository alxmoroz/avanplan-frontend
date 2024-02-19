// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';

Future showReleaseNotesDialog() async => await showMTDialog(const _ReleaseNotesDialog());

class _ReleaseNotesDialog extends StatelessWidget {
  const _ReleaseNotesDialog();

  Widget _rnBuilder(BuildContext _, int index) {
    final rn = releaseNoteController.releaseNotes[index];
    return MTListTile(
      middle: H3('${rn.version}: ${rn.title}'),
      subtitle: BaseText(rn.description),
      bottomDivider: index < releaseNoteController.releaseNotes.length - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: P3),
          H2(loc.whats_new, align: TextAlign.center),
          const SizedBox(height: P3),
          ListView.builder(
            shrinkWrap: true,
            itemCount: releaseNoteController.releaseNotes.length,
            itemBuilder: _rnBuilder,
          ),
          const SizedBox(height: P3),
          MTButton.main(titleText: loc.ok, onTap: () => Navigator.of(context).pop()),
          if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
        ],
      ),
    );
  }
}
