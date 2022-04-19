// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../components/colors.dart';
import '../presenters/date_presenter.dart';
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
                  calendarIcon(context, size: 16, color: iconColor ?? darkGreyColor),
                  if (titleString.isNotEmpty) ...[
                    const SizedBox(width: 2),
                    SmallText(titleString, weight: FontWeight.w300),
                  ]
                ],
              ),
              MediumText(date!.strShort, color: darkGreyColor),
            ],
          )
        : Container();
  }
}
