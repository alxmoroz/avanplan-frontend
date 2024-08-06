// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/calendar.dart';
import '../../../L1_domain/entities/calendar_event.dart';
import '../../../L1_domain/entities_extensions/calendar_event.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/field.dart';
import '../../components/field_data.dart';
import '../../components/icons.dart';
import '../../components/linkify.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/date.dart';

Future showEventDialog(CalendarEvent event) async => await showMTDialog(_EventDialog(event));

class _EventDialog extends StatelessWidget {
  const _EventDialog(this.event);
  final CalendarEvent event;

  Calendar? get _calendar => calendarController.calendarForId(event.calendarId);

  static const _titleMaxLines = 5;
  static const _descriptionMaxLines = 20;

  Widget _header(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_calendar != null) BaseText(_calendar!.title),
            const SizedBox(height: P),
            MTLinkify(
              event.title,
              maxLines: _titleMaxLines,
              style: const H1('', maxLines: _titleMaxLines).style(context),
            ),
          ],
        ),
      );

  Widget _description(BuildContext context) => MTListTile(
        leading: const DescriptionIcon(color: f2Color),
        middle: MTLinkify(event.description, maxLines: _descriptionMaxLines),
        margin: const EdgeInsets.only(top: P3),
        crossAxisAlignment: CrossAxisAlignment.start,
        bottomDivider: false,
      );

  Widget _date(DateTime date) => Row(children: [
        BaseText.f2(DateFormat.E().format(date), maxLines: 1),
        const SizedBox(width: P),
        BaseText(date.strMedium, maxLines: 1),
        if (!event.allDay && event.days > 0) BaseText(', ${date.strTime}', maxLines: 1),
      ]);

  Widget get _dates => MTField(
        MTFieldData(-1, label: loc.calendar_event_dates_title),
        leading: const CalendarIcon(color: f2Color),
        value: Column(
          children: [
            _date(event.startDate),
            if (event.days > 0) ...[const SizedBox(height: P), _date(event.endDate)]
          ],
        ),
        trailing: event.allDay
            ? BaseText.f2(loc.calendar_event_all_day_label_title)
            : event.days > 0
                ? null
                : Column(
                    children: [
                      BaseText(event.startDate.strTime),
                      BaseText(event.endDate.strTime),
                    ],
                  ),
        margin: const EdgeInsets.only(top: P3),
      );

  Widget get _location => MTField(
        MTFieldData(-1, label: loc.calendar_event_location_title),
        leading: const LocationIcon(color: f2Color, size: P6),
        value: BaseText(event.location, maxLines: 3),
        margin: const EdgeInsets.only(top: P3),
      );

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(
        title: loc.calendar_event_title,
        color: b2Color,
        showCloseButton: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          _header(context),
          if (event.description.isNotEmpty) _description(context),
          _dates,
          if (event.location.isNotEmpty) _location,
          if (event.sourceLink.isNotEmpty) ...[
            MTButton.main(
              titleText: loc.task_go2source_title,
              margin: const EdgeInsets.only(top: P3),
              onTap: () => launchUrlString(event.sourceLink),
            ),
            if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
          ],
        ],
      ),
    );
  }
}
