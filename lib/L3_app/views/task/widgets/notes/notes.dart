// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/linkify.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../presenters/bytes.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/note.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/ws_member.dart';
import '../../controllers/notes_controller.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/attachments.dart';
import 'note_menu_dialog.dart';

class Notes extends StatelessWidget {
  Notes(this._taskController) : super(key: _taskController.notesWidgetGlobalKey);

  final TaskController _taskController;
  NotesController get _notesController => _taskController.notesController;

  Task get _task => _taskController.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P3),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _notesController.sortedNotesDates.length,
          itemBuilder: (_, index) {
            final gDate = _notesController.sortedNotesDates[index];
            final ng = _notesController.notesGroups[gDate]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SmallText('${gDate.strMedium}, ${DateFormat.EEEE().format(gDate)}', color: f2Color, align: TextAlign.center),
                const SizedBox(height: P2),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ng.length,
                  itemBuilder: (_, index) {
                    final n = ng[index];
                    final author = _task.memberForId(n.authorId);
                    final authorIcon = author != null ? author.icon(P3) : const PersonIcon(size: P6, color: f3Color);
                    final authorName = author != null ? '$author' : 'Deleted member';
                    final mine = n.isMine(_task);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!mine) ...[authorIcon, const SizedBox(width: P)],
                        Expanded(
                          child: MTCardButton(
                            margin: EdgeInsets.only(left: mine ? P12 : 0, right: mine ? 0 : P8, bottom: P2),
                            padding: EdgeInsets.zero,
                            loading: n.loading,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                MTListTile(
                                  middle: mine ? null : BaseText.medium(authorName, padding: const EdgeInsets.symmetric(horizontal: P2), maxLines: 1),
                                  padding: EdgeInsets.zero,
                                  bottomDivider: false,
                                  trailing: _task.canComment && mine
                                      ? MTButton.icon(
                                          const MenuIcon(size: P4),
                                          padding: const EdgeInsets.only(left: P3, right: P_2, top: P, bottom: P),
                                          onTap: () => noteMenuDialog(_taskController, n),
                                        )
                                      : null,
                                ),
                                if (n.text.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: P2).copyWith(top: P_2),
                                    child: MTLinkify(n.text, maxLines: 42),
                                  ),
                                if (n.attachments.isNotEmpty)
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: n.attachments.length,
                                    itemBuilder: (_, index) {
                                      final a = n.attachments[index];
                                      return MTListTile(
                                        leading: MimeTypeIcon(a.type),
                                        middle: BaseText(a.title, maxLines: 1),
                                        subtitle: SmallText(a.bytes.humanBytesStr, maxLines: 1),
                                        padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
                                        dividerIndent: P8,
                                        bottomDivider: false,
                                        onTap: () => _taskController.attachmentsController.download(a),
                                      );
                                    },
                                  ),
                                SmallText(
                                  n.createdOn!.strTime,
                                  align: TextAlign.right,
                                  padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P_2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
