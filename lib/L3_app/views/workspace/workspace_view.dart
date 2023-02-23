// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/tariff_presenter.dart';
import 'workspace_view_controller.dart';

class WorkspaceView extends StatefulWidget {
  const WorkspaceView(this.ws);
  final Workspace ws;

  static String get routeName => '/workspace';
  @override
  State<WorkspaceView> createState() => _WorkspaceViewState();
}

class _WorkspaceViewState extends State<WorkspaceView> {
  late WorkspaceViewController controller;

  Workspace get ws => controller.ws ?? widget.ws;

  @override
  void initState() {
    controller = WorkspaceViewController(widget.ws);
    super.initState();
  }

  Widget get _header => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P_2),
        child: Column(
          children: [
            H3(ws.title, align: TextAlign.center),
            if (ws.description.isNotEmpty) NormalText(ws.description),
          ],
        ),
      );

  Widget get _tariffs => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: P),
          MTListTile(
            middle: Column(children: [LightText(loc.tariff_title), H4(ws.tariff.title)]),
            subtitle: LightText(ws.tariff.description),
          ),
        ],
      );

  Widget get _users => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: P),
          H4(loc.member_list_title, padding: const EdgeInsets.symmetric(horizontal: P)),
          for (final user in ws.users)
            MTListTile(
              leading: user.icon(P2),
              titleText: '$user',
              subtitle: LightText(user.rolesStr),
            )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, title: loc.workspace_title, bgColor: backgroundColor),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header,
              // TODO: ВКЛАДКИ?
              _tariffs,
              _users,
            ],
          ),
        ),
      ),
    );
  }
}
