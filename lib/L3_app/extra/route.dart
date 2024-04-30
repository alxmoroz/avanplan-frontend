// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../L2_data/services/platform.dart';
import '../components/adaptive.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/dialog.dart';
import '../views/loader/loader_screen.dart';
import 'services.dart';

class MTRoute extends GoRoute {
  MTRoute({
    required this.baseName,
    String? path,
    this.parent,
    super.routes,
    super.redirect,
    GoRouterWidgetBuilder? builder,
  }) : super(
          path: path ?? '/',
          builder: builder ?? (_, __) => Container(),
        );

  final String baseName;
  final MTRoute? parent;

  @override
  String get name => '${parent?.name ?? ''}/$baseName';

  double get dialogMaxWidth => SCR_S_WIDTH;

  bool isDialog(BuildContext context) => false;

  String? title(GoRouterState state) => null;

  @override
  GoRouterPageBuilder? get pageBuilder => (BuildContext context, GoRouterState state) {
        if (isWeb) {
          final pageTitle = title(state) ?? '';
          SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
            label: '${loc.app_title}${pageTitle.isNotEmpty ? ' | $pageTitle' : ''}',
            primaryColor: mainColor.resolve(context).value,
          ));
        }

        final child = Observer(
          builder: (_) => Stack(
            alignment: Alignment.center,
            children: [
              builder!(context, state),
              if (loader.loading) const LoaderScreen(),
            ],
          ),
        );

        return isDialog(context)
            ? MTDialogPage(
                name: state.name,
                arguments: state.extra,
                maxWidth: dialogMaxWidth,
                key: state.pageKey,
                child: child,
              )
            : isBigScreen(context)
                ? NoTransitionPage(
                    name: state.name,
                    arguments: state.extra,
                    key: state.pageKey,
                    child: child,
                  )
                : MaterialPage(
                    name: state.name,
                    arguments: state.extra,
                    key: state.pageKey,
                    child: child,
                  );
      };
}
