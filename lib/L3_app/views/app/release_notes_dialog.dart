// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/release_note.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/toolbar.dart';
import '../../navigation/router.dart';
import 'services.dart';

Future showReleaseNotesDialog(List<ReleaseNote> rNotes) async => await showMTDialog(_ReleaseNotesDialog(rNotes));

class _ReleaseNotesDialog extends StatelessWidget {
  const _ReleaseNotesDialog(this._releaseNotes);
  final List<ReleaseNote> _releaseNotes;

  Widget _rnBuilder(BuildContext _, int index) {
    final rn = _releaseNotes[index];
    return Column(mainAxisSize: MainAxisSize.min, children: [
      MTListText.h3(rn.title, topMargin: 0),
      MTListText(rn.description),
      const SizedBox(height: P2),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.app_whats_new),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _releaseNotes.length,
        itemBuilder: _rnBuilder,
      ),
      bottomBar: MTBottomBar(middle: MTButton.secondary(titleText: loc.ok, onTap: router.pop)),
    );
  }
}
