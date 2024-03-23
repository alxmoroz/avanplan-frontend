// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/release_note.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';

Future showReleaseNotesDialog(List<ReleaseNote> rNotes) async => await showMTDialog(_ReleaseNotesDialog(rNotes));

class _ReleaseNotesDialog extends StatelessWidget {
  const _ReleaseNotesDialog(this._releaseNotes);
  final List<ReleaseNote> _releaseNotes;

  Widget _rnBuilder(BuildContext _, int index) {
    final rn = _releaseNotes[index];
    return Column(mainAxisSize: MainAxisSize.min, children: [
      MTListGroupTitle(middle: H3(rn.title)),
      MTListTile(
        middle: BaseText(rn.description),
        bottomDivider: false,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(
        middle: H3(loc.app_whats_new, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P3)),
        showCloseButton: true,
        color: b2Color,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _releaseNotes.length,
        itemBuilder: _rnBuilder,
      ),
      bottomBar: MTAppBar(
        isBottom: true,
        color: b2Color,
        padding: EdgeInsets.only(top: P2, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
        middle: MTButton.main(titleText: loc.ok, onTap: () => Navigator.of(context).pop()),
      ),
    );
  }
}
