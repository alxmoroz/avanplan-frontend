// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan/L3_app/components/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/button.dart';
import '../../../components/circular_progress.dart';
import '../../../components/colors.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../components/icons.dart';
import '../../../components/list_tile.dart';
import '../../../components/toolbar.dart';
import '../../../extra/services.dart';

Future showViewSettingsDialog() async => await showMTDialog<void>(const _ViewSettingsDialog());

class _ViewSettingsDialog extends StatelessWidget {
  const _ViewSettingsDialog();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.my_tasks_view_settings_title),
        body: calendarController.loading
            ? const SizedBox(height: P * 30, child: Center(child: MTCircularProgress()))
            : ListView(
                shrinkWrap: true,
                children: [
                  if (calendarController.sources.isNotEmpty) ...[
                    MTListSection(titleText: loc.calendar_connected_list_title),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: calendarController.sources.length,
                        itemBuilder: (_, index) {
                          final cs = calendarController.sources.elementAt(index);
                          return MTListTile(
                            leading: BaseText(cs.type.name),
                            titleText: cs.email,
                            bottomDivider: index < calendarController.sources.length - 1,
                          );
                        }),
                    const SizedBox(height: P3),
                  ],
                  Align(
                    child: MTButton.main(
                      leading: const PlusIcon(color: mainBtnTitleColor),
                      titleText: loc.calendar_connect_action_google_title,
                      padding: const EdgeInsets.symmetric(horizontal: P5),
                      constrained: false,
                      onTap: calendarController.authenticateGoogleCalendar,
                    ),
                  ),
                  if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
                ],
              ),
      ),
    );
  }
}
