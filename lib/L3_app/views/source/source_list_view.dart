// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_card.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../presenters/ws_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import 'source_add_menu.dart';
import 'source_edit_view.dart';

class SourceListView extends StatelessWidget {
  static String get routeName => '/sources';

  Workspace get ws => mainController.selectedWS!;

  Widget _sourceBuilder(BuildContext context, int index) {
    final s = ws.sortedSources[index];
    return MTCardButton(
      elevation: cardElevation,
      child: s.info(context),
      onTap: () => editSource(src: s),
      padding: const EdgeInsets.symmetric(horizontal: P, vertical: P2),
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
                  itemBuilder: (_, int index) => _sourceBuilder(context, index),
                  itemCount: ws.sources.length,
                ),
        ),
        bottomBar: mainController.rootTask.canImport
            ? Row(children: [
                Expanded(
                  child: ws.sources.isEmpty ? SourceAddMenu(title: loc.source_title_new) : const SizedBox(),
                ),
                if (ws.sources.isNotEmpty) const SourceAddMenu(),
              ])
            : null,
      ),
    );
  }
}
