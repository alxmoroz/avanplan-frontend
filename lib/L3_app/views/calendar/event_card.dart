// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/calendar_event.dart';
import '../../../../../L1_domain/entities_extensions/calendar_event.dart';
import '../../../../../L1_domain/utils/dates.dart';
import '../../../L1_domain/entities/calendar.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/circle.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../presenters/date.dart';
import '../../presenters/task_state.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../app/services.dart';
import 'event_dialog.dart';

class EventCard extends StatelessWidget {
  const EventCard(
    this.event, {
    super.key,
    this.showStateMark = false,
    this.bottomDivider = false,
    this.isFirst = false,
  });

  final CalendarEvent event;
  final bool bottomDivider;
  final bool showStateMark;
  final bool isFirst;

  Calendar? get _calendar => calendarController.calendarForId(event.calendarId);
  Color? get _textColor => null;

  Widget _error(String errText) => Row(children: [
        const ErrorIcon(),
        const SizedBox(width: P_2),
        SmallText(errText, color: _textColor, maxLines: 1),
      ]);

  Color get _datesColor => event.startDate.isBefore(tomorrow) ? stateColor(event.state) : _textColor ?? f2Color;
  Widget get _dates => Row(
        children: [
          CalendarIcon(color: _datesColor, size: P3),
          const SizedBox(width: P_2),
          SmallText(event.startDate.strMedium, color: _datesColor, maxLines: 1),
          if (event.days > 0) SmallText(' - ${event.endDate.strMedium}', color: _datesColor, maxLines: 1),
        ],
      );

  Widget get _content => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P2),
          BaseText(event.title, maxLines: 2, color: _textColor),
          // ошибки
          if (event.error != null) _error(event.error!.message),
          const SizedBox(height: P_2),
          if (event.state != TaskState.TODAY) _dates,
        ],
      );

  Future _tap() async => await showEventDialog(event);

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          MTListTile(
            leading: showStateMark ? const SizedBox(width: P) : null,
            middle: _content,
            trailing: Row(
              children: [
                if (!event.allDay && event.days < 1) ...[
                  const SizedBox(width: P_2),
                  Column(
                    children: [
                      SmallText(event.startDate.strTime, color: f1Color),
                      SmallText(event.endDate.strTime),
                    ],
                  ),
                ],
                const SizedBox(width: P_2),
                if (!kIsWeb) const ChevronIcon(),
              ],
            ),
            bottomDivider: bottomDivider,
            dividerIndent: showStateMark ? P6 : 0,
            loading: event.loading,
            onTap: _tap,
          ),
          // метка события
          Positioned(
            left: P3 + 1,
            top: isFirst ? 0 : -1,
            child: Container(
              decoration: BoxDecoration(
                color: (_calendar?.hasColors == true ? _calendar!.bgColor! : b1Color).resolve(context),
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(P)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: P),
                  const MTCircle(color: b3Color, size: P),
                  const SizedBox(width: P - 1),
                  SmallText(
                    event.allDay ? loc.calendar_event_all_day_label_title : loc.calendar_event_title.toLowerCase(),
                    color: _calendar?.hasColors == true ? _calendar!.fgColor! : f2Color,
                  ),
                  const SizedBox(width: P3),
                ],
              ),
            ),
          ),
          if (showStateMark)
            Positioned(
              left: P3,
              top: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(gradient: stateGradient(context, event.state)),
                width: P,
              ),
            ),
        ],
      );
}
