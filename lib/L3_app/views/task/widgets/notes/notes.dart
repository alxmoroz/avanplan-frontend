// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities/note.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
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
import '../../../../presenters/date.dart';
import '../../../../presenters/note.dart';
import '../../../../presenters/person.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/notes_controller.dart';

class Notes extends StatelessWidget {
  Notes(this._controller) : super(key: _controller.notesWidgetGlobalKey);

  final NotesController _controller;

  Task get _task => _controller.task;
  bool get _canEditTask => _task.canComment;

  Future _noteMenu(BuildContext context, Note note) async => await showMTDialog<void>(
        MTDialog(
          topBar: MTAppBar(showCloseButton: true, bgColor: b2Color, title: loc.task_note_title),
          body: ListView(
            shrinkWrap: true,
            children: [
              MTListTile(
                leading: const EditIcon(),
                middle: BaseText(loc.edit_action_title, color: mainColor, maxLines: 1),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _controller.edit(note);
                },
              ),
              MTListTile(
                leading: const DeleteIcon(),
                middle: BaseText(loc.delete_action_title, color: dangerColor, maxLines: 1),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _controller.delete(note);
                },
              ),
            ],
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
          itemCount: _controller.sortedNotesDates.length,
          itemBuilder: (_, index) {
            final gDate = _controller.sortedNotesDates[index];
            final ng = _controller.notesGroups[gDate]!;
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
                            margin: EdgeInsets.only(left: mine ? P6 + P6 : 0, right: mine ? 0 : P4, bottom: P2),
                            padding: const EdgeInsets.symmetric(vertical: P, horizontal: P2),
                            loading: n.loading,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (!mine) BaseText.medium(authorName),
                                Linkify(
                                  text: n.text,
                                  style: const BaseText('', maxLines: 42).style(context),
                                  linkStyle: const BaseText('', color: mainColor).style(context),
                                  onOpen: (link) async => await launchUrlString(link.url),
                                ),
                                SmallText(n.createdOn!.strTime, align: TextAlign.right),
                              ],
                            ),
                            onLongPress: _canEditTask && mine ? () => _noteMenu(context, n) : null,
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
