// Copyright (c) 2024. Alexandr Moroz

import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../extra/route.dart';
import '../../extra/services.dart';
import 'auth_view.dart';

part 'registration_token_controller.g.dart';

final registrationTokenRoute = MTRoute(
  path: '/register',
  baseName: 'register',
  redirect: (_, GoRouterState state) {
    registrationTokenController.parseLink(state.uri);
    return authRoute.path;
  },
);

class RegistrationTokenController extends _RegistrationTokenControllerBase with _$RegistrationTokenController {}

abstract class _RegistrationTokenControllerBase with Store {
  @observable
  String? token;

  @action
  void clear() => token = null;

  @computed
  bool get hasToken => token?.isNotEmpty == true;

  @action
  void parseLink(Uri uri) {
    final params = uri.queryParameters;
    const key = 't';

    if (params.containsKey(key)) {
      token = params[key] ?? '';
    }
  }
}
