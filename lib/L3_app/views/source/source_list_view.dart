// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../presenters/ws_presenter.dart';
import '../../usecases/ws_ext_actions.dart';
import 'source_edit_view.dart';

class SourceListView extends StatelessWidget {
  const SourceListView(this.wsId);
  final int wsId;
  Workspace get ws => mainController.wsForId(wsId);

  static String get routeName => '/sources';

  Widget _sourceBuilder(BuildContext _, int index) {
    final s = ws.sortedSources[index];
    return s.listTile(
      bottomBorder: index < ws.sortedSources.length - 1,
      padding: const EdgeInsets.all(P),
      onTap: () => editSource(ws, src: s),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          middle: ws.subPageTitle(loc.source_list_title),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ws.sources.isEmpty
              ? Center(child: H4(loc.source_list_empty_title, align: TextAlign.center, color: lightGreyColor))
              : ListView.builder(
                  itemBuilder: _sourceBuilder,
                  itemCount: ws.sources.length,
                ),
        ),
        bottomBar: ws.hpSourceCreate
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (ws.sources.isNotEmpty) const Spacer(),
                  ws.sources.isEmpty
                      ? MTButton.outlined(
                          leading: const PlusIcon(),
                          titleText: loc.source_title_new,
                          onTap: () => startAddSource(ws),
                        )
                      : MTPlusButton(() => startAddSource(ws))
                ],
              )
            : null,
      ),
    );
  }
}
