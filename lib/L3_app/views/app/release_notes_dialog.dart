// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/release_note.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../navigation/router.dart';

Future showReleaseNotesDialog(List<ReleaseNote> rNotes) async => await showMTDialog(_ReleaseNotesDialog(rNotes));

class _ReleaseNotesDialog extends StatelessWidget {
  const _ReleaseNotesDialog(this._releaseNotes);
  final List<ReleaseNote> _releaseNotes;

  Widget _rnBuilder(BuildContext _, int index) {
    final rn = _releaseNotes[index];
    return Column(mainAxisSize: MainAxisSize.min, children: [
      MTListGroupTitle(middle: H3(rn.title), topMargin: 0),
      MTListTile(
        middle: BaseText(rn.description),
        bottomDivider: false,
      ),
      const SizedBox(height: P2),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(middle: H3(loc.app_whats_new, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P3))),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _releaseNotes.length,
        itemBuilder: _rnBuilder,
      ),
      bottomBar: MTBottomBar(
        inBigDialog: true,
        padding: EdgeInsets.only(top: P2, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
        middle: MTButton.secondary(titleText: loc.ok, onTap: router.pop),
      ),
    );
  }
}
