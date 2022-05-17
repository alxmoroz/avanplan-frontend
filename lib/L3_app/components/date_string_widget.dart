// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../presenters/date_presenter.dart';
import 'colors.dart';
import 'constants.dart';
import 'icons.dart';
import 'text_widgets.dart';

class DateStringWidget extends StatelessWidget {
  const DateStringWidget(this.date, {this.titleString = '', this.iconColor});

  final DateTime? date;
  final Color? iconColor;
  final String titleString;

  @override
  Widget build(BuildContext context) {
    return date != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  calendarIcon(context, size: onePadding * 1.5, color: iconColor ?? darkGreyColor),
                  if (titleString.isNotEmpty) ...[
                    SizedBox(width: onePadding / 6),
                    SmallText(titleString),
                  ]
                ],
              ),
              LightText(date!.strShort),
            ],
          )
        : Container();
  }
}
