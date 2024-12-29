// Copyright (c) 2024. Alexandr Moroz

import 'package:go_router/go_router.dart';

import '../../L1_domain/entities/app_local_settings.dart';
import '../../L2_data/services/environment.dart';
import '../views/app/services.dart';
import '../views/auth/auth_view.dart';
import '../views/main/main_view.dart';
import 'route.dart';

final registrationTokenRoute = MTRoute(
  path: '/register',
  baseName: 'register',
  redirect: (_, GoRouterState state) async {
    await localSettingsController.parseQueryParameter(state.uri, 't', ALSStringCode.REGISTRATION_TOKEN);
    return authRoute.path;
  },
);

final invitationTokenRoute = MTRoute(
  path: '/invite',
  baseName: 'invite',
  redirect: (_, GoRouterState state) async {
    await localSettingsController.parseQueryParameter(state.uri, 't', ALSStringCode.INVITATION_TOKEN);
    return mainRoute.path;
  },
);

final yandexOauthWebRedirectRoute = MTRoute(
  path: yandexOauthRedirectUri.path,
  baseName: yandexOauthRedirectUri.pathSegments.first,
  redirect: (_, GoRouterState state) async {
    authController.setYandexRedirectUri(state.uri);
    return authRoute.path;
  },
);
