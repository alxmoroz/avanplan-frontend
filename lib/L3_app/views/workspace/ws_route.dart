// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import '../../navigation/route.dart';
import '../../navigation/router.dart';
import '../source/sources_dialog.dart';
import 'ws_controller.dart';
import 'ws_dialog.dart';
import 'ws_users_dialog.dart';

class WSRoute extends MTRoute {
  static const staticBaseName = 'ws';

  WSRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: 'ws_:wsId',
          controller: WSController(),
        );

  @override
  List<RouteBase> get routes => [
        WSSourcesRoute(parent: this),
        WSUsersRoute(parent: this),
      ];

  @override
  String title(GoRouterState state) => '${loc.workspace_title_short} ${_wsd.code}';

  @override
  bool isDialog(BuildContext context) => true;

  WSController get _wsc => controller as WSController;
  Workspace get _wsd => _wsc.wsDescriptor;

  @override
  GoRouterRedirect? get redirect => (_, state) {
        _wsc.init(state.pathParamInt('wsId')!);
        return null;
      };

  @override
  GoRouterWidgetBuilder? get builder => (_, __) => WSDialog(_wsc);
}
