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
import '../../../components/mt_text_field.dart';
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

  Widget _tf(BuildContext context, String code, {EdgeInsets? margin}) {
    final ta = controller.tfa(code);
    final isDate = code.endsWith('Date');
    final teController = controller.teControllers[code];
    return Stack(
      alignment: Alignment.center,
      children: [
        ta.noText
            ? MTTextField.noText(
                controller: teController,
                enabled: !ta.loading,
                label: ta.label,
                error: ta.errorText,
                margin: margin,
                onTap: isDate ? () => controller.selectDate(code) : null,
                prefixIcon: isDate ? const CalendarIcon() : null,
                suffixIcon: isDate && ta.text.isNotEmpty
                    ? MTButton(
                        middle: Row(
                          children: [
                            Container(height: P * 3, width: 1, color: borderColor.resolve(context)),
                            const SizedBox(width: P),
                            const CloseIcon(color: dangerColor),
                            const SizedBox(width: P),
                          ],
                        ),
                        onTap: () => controller.resetDate(code),
                      )
                    : null,
              )
            : MTTextField(
                controller: teController,
                enabled: !ta.loading,
                label: ta.label,
                error: ta.errorText,
                margin: margin,
              ),
        if (ta.loading) ...[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              color: backgroundColor.resolve(context).withAlpha(150),
            ),
          ),
          CircularProgressIndicator(color: mainColor.resolve(context)),
        ]
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        child: MTAdaptive(
          child: ListView(
            children: [
              if (_task.hasStatus || _closable) ...[
                const SizedBox(height: P),
                MTListTile(
                  middle: Row(
                    children: [
                      if (_task.hasStatus)
                        MTButton.main(
                          titleText: '${_task.status}',
                          constrained: false,
                          padding: const EdgeInsets.symmetric(horizontal: P2),
                          // margin: const EdgeInsets.only(left: P),
                          onTap: _task.canSetStatus ? controller.selectStatus : null,
                        ),
                      if (_closable)
                        MTButton(
                          titleColor: greenColor,
                          titleText: loc.close_action_title,
                          leading: const DoneIcon(true, color: greenColor),
                          margin: const EdgeInsets.only(left: P2),
                          onTap: () => controller.setStatus(_task, close: true),
                        )
                    ],
                  ),
                ),
              ],
              if (_task.hasAssignee) ...[
                // _task.canUpdate ? MTButton.secondary(middle: _assignee) :
                MTListTile(leading: LightText(loc.task_assignee_placeholder, color: lightGreyColor), middle: _assignee),
              ],
              if (_task.hasDescription) ...[
                _description(context),
              ],
              MTListTile(
                padding: MTListTile.defaultPadding.copyWith(top: P2),
                middle: _tf(context, 'startDate', margin: EdgeInsets.zero),
                bottomBorder: false,
              ),
              MTListTile(
                middle: _tf(context, 'dueDate', margin: EdgeInsets.zero),
                bottomBorder: false,
              ),
              // MTListTile(
              //   middle: Row(
              //     children: [
              //       Flexible(child: _tf(context, 'startDate', margin: EdgeInsets.zero)),
              //       Flexible(child: _tf(context, 'dueDate', margin: EdgeInsets.only(left: P))),
              //     ],
              //   ),
              // ),
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
                  bottomBorder: false,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
