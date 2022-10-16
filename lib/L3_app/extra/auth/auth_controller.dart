// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/ws_role.dart';
import '../services.dart';

part 'auth_controller.g.dart';

class AuthController extends _AuthControllerBase with _$AuthController {
  Future<AuthController> init() async {
    await authUC.setApiCredentialsFromLocalAuth();
    _setAuthorized(await authUC.isLocalAuthorized());
    return this;
  }
}

abstract class _AuthControllerBase with Store {
  @observable
  bool authorized = false;

  @action
  void _setAuthorized(bool _auth) => authorized = _auth;

  Future authorize(String login, String password) async {
    _setAuthorized(await authUC.authorize(username: login, password: password));
  }

  Future authorizeWithGoogle() async {
    _setAuthorized(await authUC.authorizeWithGoogle());
  }

  Future logout() async {
    _setAuthorized(false);
    await authUC.logout();
  }

  bool canEditWS(Iterable<WSRole> roles) => roles.firstWhereOrNull((r) => r.title == 'admin') != null;
}
