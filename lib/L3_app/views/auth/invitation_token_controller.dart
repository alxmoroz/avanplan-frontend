// Copyright (c) 2024. Alexandr Moroz

import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../extra/route.dart';
import '../../extra/services.dart';
import '../main/main_view.dart';

part 'invitation_token_controller.g.dart';

final invitationTokenRoute = MTRoute(
  path: '/invite',
  baseName: 'invite',
  // TODO: здесь можно показать проект, куда добавили человека
  redirect: (_, GoRouterState state) {
    invitationTokenController.parseLink(state.uri);
    return mainRoute.path;
  },
);

class InvitationTokenController extends _InvitationTokenControllerBase with _$InvitationTokenController {}

abstract class _InvitationTokenControllerBase with Store {
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
