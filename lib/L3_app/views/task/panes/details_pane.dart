// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/person_presenter.dart';

class DetailsPane extends StatelessWidget {
  const DetailsPane(this.task);
  final Task task;

  bool get hasDescription => task.description.isNotEmpty;
  bool get hasAuthor => task.author != null;

  Widget description(BuildContext context) => SelectableLinkify(
        text: task.description,
        style: const LightText('').style(context),
        linkStyle: const NormalText('', color: mainColor).style(context),
        onOpen: (link) async => await launchUrlString(link.url),
      );

  Widget? get bottomBar => null;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ListView(
      padding: padding.add(const EdgeInsets.all(P).copyWith(bottom: padding.bottom > 0 ? 0 : P)),
      children: [
        if (hasDescription) description(context),
        if (hasAuthor) ...[
          const SizedBox(height: P_2),
          Row(children: [const Spacer(), task.author!.iconName()]),
        ],
      ],
    );
  }
}
