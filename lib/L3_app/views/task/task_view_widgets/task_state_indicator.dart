// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_overview_presenter.dart';

enum IndicatorPlacement { card, workspace, other }

class TaskStateIndicator extends StatelessWidget {
  const TaskStateIndicator(this.task, {this.placement = IndicatorPlacement.other});

  @protected
  final Task task;
  @protected
  final IndicatorPlacement placement;

  bool get _inCard => placement == IndicatorPlacement.card;
  bool get _inWorkspace => placement == IndicatorPlacement.workspace;
  Color get _color => _inCard ? darkGreyColor : task.stateColor ?? darkGreyColor;
  String get _text => task.stateTextDetails ?? task.stateTextTitle;

  Widget get _textWidget => _inCard
      ? SmallText(_text, color: _color)
      : _inWorkspace
          ? H3(
              _text,
              color: _color,
              align: TextAlign.center,
              padding: EdgeInsets.symmetric(horizontal: onePadding),
            )
          : H4(
              _text,
              color: _color,
              align: TextAlign.center,
              padding: EdgeInsets.symmetric(horizontal: onePadding),
            );

  Widget _icon(BuildContext context) => task.stateIcon(
        context,
        size: onePadding *
            (_inCard
                ? 1.3
                : _inWorkspace
                    ? 10
                    : 3),
        color: _color,
      );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (!_inCard) _icon(context),
      Row(children: [
        if (_inCard) ...[_icon(context), SizedBox(width: onePadding / 4)],
        Expanded(child: _textWidget),
      ]),
    ]);
  }
}
