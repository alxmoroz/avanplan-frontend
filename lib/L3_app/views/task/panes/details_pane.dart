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
import '../../../components/icons.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_list_tile.dart';
import '../../../components/mt_shadowed.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/person_presenter.dart';
import '../../../presenters/source_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../../../usecases/task_ext_refs.dart';
import '../task_view_controller.dart';

class DetailsPane extends StatelessWidget {
  const DetailsPane(this.controller);
  final TaskViewController controller;

  Task get _task => controller.task;

  Widget _description(BuildContext context) {
    return MTListTile(
      middle: SelectableLinkify(
        text: _task.description,
        style: const LightText('').style(context),
        linkStyle: const NormalText('', color: mainColor).style(context),
        onOpen: (link) async => await launchUrlString(link.url),
      ),
    );
  }

  Widget? get bottomBar => _task.hasLink
      ? MTButton(
          middle: _task.taskSource!.go2SourceTitle(showSourceIcon: true),
          onTap: () => launchUrlString(_task.taskSource!.urlString),
        )
      : null;

  bool get _closable => _task.canCloseGroup || _task.canCloseLeaf;

  Widget get _assignee => _task.assignee!.iconName();
  Widget get _author => _task.author!.iconName();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        child: MTAdaptive(
          child: ListView(
            children: [
              if (_task.hasStatus || _closable) ...[
                const SizedBox(height: P),
                Row(
                  children: [
                    if (_task.hasStatus)
                      MTButton.main(
                        titleText: '${_task.status}',
                        constrained: false,
                        padding: const EdgeInsets.symmetric(horizontal: P2),
                        margin: const EdgeInsets.only(left: P),
                        onTap: _task.canSetStatus ? controller.selectStatus : null,
                      ),
                    if (_closable)
                      MTButton(
                        titleColor: greenColor,
                        titleText: loc.close_action_title,
                        leading: const DoneIcon(true, color: greenColor),
                        margin: const EdgeInsets.only(left: P),
                        onTap: () => controller.setStatus(_task, close: true),
                      ),
                  ],
                ),
                const SizedBox(height: P),
              ],
              if (_task.hasAssignee) ...[
                _task.canUpdate ? MTButton.secondary(middle: _assignee) : MTListTile(middle: _assignee),
              ],
              if (_task.hasDescription) ...[
                _description(context),
              ],
              if (_task.hasEstimate) ...[
                MTListTile(
                  leading: LightText('${loc.task_estimate_placeholder}', color: lightGreyColor),
                  middle: NormalText('${_task.estimate} ${loc.task_estimate_unit}'),
                ),
              ],
              if (_task.hasAuthor) ...[
                MTListTile(
                  leading: LightText(loc.task_author_title, color: lightGreyColor),
                  middle: _author,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
