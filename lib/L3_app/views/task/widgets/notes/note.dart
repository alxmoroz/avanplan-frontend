// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/note.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/linkify/linkify.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../presenters/bytes.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/note.dart';
import '../../../../presenters/ws_member.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/attachments.dart';
import 'note_menu_dialog.dart';

class NoteCard extends StatelessWidget {
  const NoteCard(
    this._tc,
    this._note, {
    super.key,
  });

  final TaskController _tc;
  final Note _note;

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;
    final preview = _tc.isPreview;
    final author = t.taskMemberForId(_note.authorId);
    final authorIcon = author != null ? author.icon(P3) : const PersonIcon(size: P6, color: f3Color);
    final mine = _note.isMine(t);
    final authorName = author != null ? '$author' : 'Deleted member';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!mine) ...[authorIcon, const SizedBox(width: P)],
        Expanded(
          child: MTCardButton(
            margin: EdgeInsets.only(left: mine ? P12 : 0, right: mine ? 0 : P8, bottom: P2),
            padding: EdgeInsets.zero,
            loading: _note.loading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const SizedBox(height: P2),
                    if (!mine)
                      BaseText.medium(
                        authorName,
                        padding: const EdgeInsets.symmetric(horizontal: P2),
                        maxLines: 1,
                        color: f2Color,
                      ),
                    const Spacer(),
                    if (_tc.canComment && mine)
                      MTButton.icon(
                        const MenuIcon(size: P4),
                        padding: const EdgeInsets.only(left: P3, right: P_2, top: P, bottom: P),
                        onTap: () => noteMenuDialog(_tc, _note),
                      ),
                  ],
                ),
                if (_note.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: P2).copyWith(top: P_2),
                    child: MTLinkify(
                      _note.text,
                      maxLines: 42,
                      style: BaseText('', maxLines: 42, color: preview ? f2Color : null).style(context),
                    ),
                  ),
                if (_note.attachments.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _note.attachments.length,
                    itemBuilder: (_, index) {
                      final a = _note.attachments[index];
                      return MTListTile(
                        leading: MimeTypeIcon(a.type),
                        middle: BaseText(a.title, maxLines: 1),
                        subtitle: SmallText(a.bytes.humanBytesStr, maxLines: 1),
                        padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
                        dividerIndent: P8,
                        bottomDivider: false,
                        onTap: () => _tc.attachmentsController.download(a),
                      );
                    },
                  ),
                SmallText(
                  _note.createdOn!.strTime,
                  align: TextAlign.right,
                  padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P_2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
