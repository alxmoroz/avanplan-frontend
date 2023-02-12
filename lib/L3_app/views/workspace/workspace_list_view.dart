// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';

class WorkspaceListView extends StatelessWidget {
  static String get routeName => '/workspaces';

  Widget _wsBuilder(BuildContext context, int index) {
    final ws = mainController.workspaces[index];
    return MTListTile(
        middle: NormalText(ws.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (ws.description.isNotEmpty) SmallText(ws.description, padding: const EdgeInsets.only(bottom: P_2)),
            for (final user in ws.users) ...[
              LightText('$user'),
              SmallText(user.rolesStr),
            ],
          ],
        )
        // trailing: editIcon(context),
        // onTap: () => _controller.editWS(context, ws: ws),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, title: loc.workspaces_title),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView.builder(
            itemBuilder: _wsBuilder,
            itemCount: mainController.workspaces.length,
          ),
        ),
      ),
    );
  }
}
