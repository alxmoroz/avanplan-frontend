// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/calendar_source.dart';
import '../../../components/button.dart';
import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../components/icons.dart';
import '../../../components/images.dart';
import '../../../components/list_tile.dart';
import '../../../components/toolbar.dart';
import '../../../views/_base/loader_screen.dart';
import '../../app/services.dart';

Future showViewSettingsDialog() async => await showMTDialog(const _ViewSettingsDialog());

class _ViewSettingsDialog extends StatelessWidget {
  const _ViewSettingsDialog();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => calendarController.loading
          ? LoaderScreen(calendarController, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(pageTitle: loc.view_settings_title),
              body: ListView(
                shrinkWrap: true,
                children: [
                  if (calendarController.sources.isNotEmpty) ...[
                    MTListGroupTitle(titleText: loc.calendar_connected_list_title),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: calendarController.sources.length,
                        itemBuilder: (_, index) {
                          final cs = calendarController.sources.elementAt(index);
                          return MTListTile(
                            leading: cs.type == CalendarSourceType.GOOGLE ? MTImage(ImageName.google_calendar.name, height: P6) : null,
                            titleText: cs.email,
                            bottomDivider: index < calendarController.sources.length - 1,
                          );
                        }),
                    const SizedBox(height: P3),
                  ],
                  Align(
                    child: MTButton.secondary(
                      leading: const PlusIcon(),
                      titleText: loc.calendar_connect_action_google_title,
                      padding: const EdgeInsets.symmetric(horizontal: P5),
                      constrained: false,
                      onTap: calendarController.authenticateGoogleCalendar,
                    ),
                  ),
                ],
              ),
              forceBottomPadding: true,
            ),
    );
  }
}
