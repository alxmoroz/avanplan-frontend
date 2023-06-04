// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/person_presenter.dart';
import '../../../usecases/task_ext_refs.dart';
import '../task_view_controller.dart';

class DetailsPane extends StatelessWidget {
  const DetailsPane(this.controller);
  final TaskViewController controller;

  Task get task => controller.task;

  Widget description(BuildContext context) => SelectableLinkify(
        text: task.description,
        style: const LightText('').style(context),
        linkStyle: const NormalText('', color: mainColor).style(context),
        onOpen: (link) async => await launchUrlString(link.url),
      );

  Widget? get bottomBar => null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P),
        child: ListView(
          children: [
            if (task.hasStatus || task.hasAssignee) ...[
              const SizedBox(height: P),
              Row(
                children: [
                  if (task.hasStatus) SmallText('${task.status}'),
                  if (task.hasAssignee) ...[
                    if (task.hasStatus) const SizedBox(width: P_2),
                    task.assignee!.iconName(),
                  ],
                ],
              ),
            ],
            if (task.hasDescription) description(context),
            if (task.hasAuthor) ...[
              const SizedBox(height: P_2),
              Row(children: [const Spacer(), task.author!.iconName()]),
            ],
          ],
        ),
      ),
    );
  }
}
