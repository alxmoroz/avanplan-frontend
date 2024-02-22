// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/notification.dart';
import '../../../L1_domain/utils/dates.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/date.dart';

Future notificationDialog() async => await showMTDialog<void>(const _NotificationDialog(), maxWidth: SCR_M_WIDTH);

class _NotificationDialog extends StatelessWidget {
  const _NotificationDialog();

  MTNotification get nf => notificationController.selectedNotification!;

  Future _tryGo(BuildContext context) async {
    Navigator.of(context).pop();
    try {
      Navigator.of(context).pushNamed(Uri.parse(nf.url!).path);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: nf.title),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: P3),
          child: ListView(
            shrinkWrap: true,
            children: [
              BaseText(nf.description, maxLines: 100),
              const SizedBox(height: P),
              SmallText('${nf.scheduledDate.date.strMedium} ${nf.scheduledDate.strTime}', maxLines: 1, align: TextAlign.right),
              if (nf.url?.isNotEmpty == true)
                MTButton.secondary(
                  margin: const EdgeInsets.only(top: P3),
                  titleText: loc.details,
                  trailing: const ChevronIcon(),
                  onTap: () => _tryGo(context),
                ),
              if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
            ],
          )),
    );
  }
}
