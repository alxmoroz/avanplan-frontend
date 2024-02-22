// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/router.dart';
import '../../extra/services.dart';

part 'invitation_token_controller.g.dart';

class InvitationTokenRouter extends MTRouter {
  @override
  String path({Object? args}) => '/invite';

  @override
  RouteSettings? get settings {
    invitationTokenController.parseLink(rs!.uri);
    return const RouteSettings(name: '/');
  }
}

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
