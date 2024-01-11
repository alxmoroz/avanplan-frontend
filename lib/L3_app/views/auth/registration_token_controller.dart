// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/router.dart';
import '../../extra/services.dart';

part 'registration_token_controller.g.dart';

class RegistrationTokenRouter extends MTRouter {
  @override
  String get path => '/register';

  @override
  RouteSettings? get settings {
    registrationTokenController.parseLink(rs!.uri);
    return const RouteSettings(name: '/');
  }
}

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
