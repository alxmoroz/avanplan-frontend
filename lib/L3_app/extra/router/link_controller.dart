// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../services.dart';

part 'link_controller.g.dart';

class LinkController = _LinkControllerBase with _$LinkController;

abstract class _LinkControllerBase with Store {
  @observable
  String? invitationToken;

  @action
  Future parseDeepLink(String? path) async {
    if (path?.startsWith('/invite') == true) {
      final params = Uri.dataFromString(path!).queryParameters;
      const key = 't';
      if (params.containsKey(key)) {
        invitationToken = params[key];
      }
    }
  }

  @action
  Future<bool> _redeemInvite() async {
    bool res = false;
    if (invitationToken != null) {
      loaderController.start();
      loaderController.setRedeemInvitation();
      if (await invitationUC.redeem(invitationToken!)) {
        invitationToken = null;
        res = true;
      }
      await loaderController.stop();
    }
    return res;
  }

  Future<bool> processDeepLinks() async {
    bool res = false;
    if (authController.authorized) {
      res = await _redeemInvite();
    }
    return res;
  }
}
