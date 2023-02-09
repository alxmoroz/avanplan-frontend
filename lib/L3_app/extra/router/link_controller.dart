// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../services.dart';

part 'link_controller.g.dart';

class LinkController = _LinkControllerBase with _$LinkController;

abstract class _LinkControllerBase with Store {
  @observable
  String? inviteLink;

  @action
  Future registerLink(String? link) async {
    if (link?.startsWith('/invite') == true) {
      inviteLink = link;
      await processLinks();
    }
  }

  @action
  Future _redeemInvite() async {
    if (inviteLink != null) {
      // TODO: запрос на бэк
      print('_redeemInvite $inviteLink');
      inviteLink = null;
    }
  }

  Future processLinks() async {
    if (authController.authorized) {
      await _redeemInvite();
    }
  }
}
