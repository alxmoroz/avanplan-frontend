// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities/note.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_button.dart';
import '../../../../components/mt_dialog.dart';
import '../../../../components/mt_list_tile.dart';
import '../../../../components/mt_toolbar.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date_presenter.dart';
import '../../../../presenters/person_presenter.dart';
import '../../../../presenters/task_note_presenter.dart';
import '../../../../usecases/task_available_actions.dart';
import '../../controllers/notes_controller.dart';

class Notes extends StatelessWidget {
  const Notes(this.controller);
  final NotesController controller;

  Task get _task => controller.task;
  bool get _canEditTask => _task.canComment;

  Future _noteMenu(BuildContext context, Note note) async => await showMTDialog<void>(
        MTDialog(
          topBar: MTTopBar(titleText: loc.task_note_title),
          body: ListView(
            shrinkWrap: true,
            children: [
              MTListTile(
                leading: const EditIcon(),
                middle: NormalText(loc.edit_action_title, color: mainColor),
                onTap: () async {
                  Navigator.of(context).pop();
                  await controller.editNote(note);
                },
              ),
              MTListTile(
                leading: const DeleteIcon(),
                middle: NormalText(loc.delete_action_title, color: dangerColor),
                onTap: () async {
                  Navigator.of(context).pop();
                  await controller.deleteNote(note);
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
        padding: const EdgeInsets.symmetric(horizontal: P + P_2),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.sortedNotesDates.length,
          itemBuilder: (_, index) {
            final gDate = controller.sortedNotesDates[index];
            final ng = controller.notesGroups[gDate]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallText(gDate.strMedium, padding: const EdgeInsets.only(right: P_3), color: greyColor),
                    SmallText(DateFormat.E().format(gDate), color: greyColor),
                  ],
                ),
                const SizedBox(height: P),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ng.length,
                  itemBuilder: (_, index) {
                    final n = ng[index];
                    final author = _task.memberForId(n.authorId);
                    final mine = n.isMine(_task);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!mine) ...[author!.icon(P * 1.5), const SizedBox(width: P_2)],
                        Expanded(
                          child: MTCardButton(
                            margin: EdgeInsets.only(left: mine ? P3 + P3 : 0, right: mine ? 0 : P2, bottom: P),
                            padding: const EdgeInsets.symmetric(vertical: P_2, horizontal: P),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (!mine) MediumText('$author'),
                                Linkify(
                                  text: n.text,
                                  style: const NormalText('', maxLines: 42).style(context),
                                  linkStyle: const NormalText('', color: mainColor).style(context),
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
