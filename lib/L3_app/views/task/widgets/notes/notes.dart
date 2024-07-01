// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities/note.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/ws_members.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/bytes.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/member.dart';
import '../../../../presenters/note.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/notes_controller.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/attachments.dart';
import '../../usecases/note_edit.dart';

class Notes extends StatelessWidget {
  Notes(this._taskController) : super(key: _taskController.notesWidgetGlobalKey);

  final TaskController _taskController;
  NotesController get _notesController => _taskController.notesController;

  Task get _task => _taskController.task;

  void _noteMenuDialog(Note note) => showMTDialog<void>(
        Builder(
          builder: (context) => MTDialog(
            topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.task_note_title),
            body: ListView(
              shrinkWrap: true,
              children: [
                MTListTile(
                  leading: const EditIcon(),
                  middle: BaseText(loc.edit_action_title, color: mainColor, maxLines: 1),
                  dividerIndent: P4 + P5,
                  onTap: () {
                    Navigator.of(context).pop();
                    _taskController.editNote(note);
                  },
                ),
                MTListTile(
                  leading: const DeleteIcon(),
                  middle: BaseText(loc.delete_action_title, color: dangerColor, maxLines: 1),
                  bottomDivider: false,
                  onTap: () async {
                    Navigator.of(context).pop();
                    _taskController.deleteNote(note);
                  },
                ),
              ],
            ),
          ),
        ),
      );

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
                    final author = _task.ws.memberForId(n.authorId);
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
                            // onLongPress: !isWeb && _canEditTask && mine ? () => _noteMenu(context, n) : null,
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
                                          onTap: () => _noteMenuDialog(n),
                                        )
                                      : null,
                                ),
                                if (n.text.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: P2).copyWith(top: P_2),
                                    child: SelectableLinkify(
                                      text: n.text,
                                      style: const BaseText('', maxLines: 42).style(context),
                                      linkStyle: const BaseText('', color: mainColor).style(context),
                                      onOpen: (link) async => await launchUrlString(link.url),
                                    ),
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
