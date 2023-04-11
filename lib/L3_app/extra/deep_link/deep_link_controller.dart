// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

part 'deep_link_controller.g.dart';

class DeepLinkController = _DeepLinkControllerBase with _$DeepLinkController;

abstract class _DeepLinkControllerBase with Store {
  @observable
  String? invitationToken;
  @action
  void clearInvitation() => invitationToken = null;
  @computed
  bool get hasInvitation => invitationToken?.isNotEmpty == true;

  @observable
  String? registrationToken;
  @action
  void clearRegistration() => registrationToken = null;
  @computed
  bool get hasRegistration => registrationToken?.isNotEmpty == true;

  @action
  void parseDeepLink(String? path) {
    if (path != null) {
      final params = Uri.dataFromString(path).queryParameters;
      const key = 't';
      if (params.containsKey(key)) {
        final token = params[key] ?? '';
        if (path.startsWith('/invite') == true) {
          invitationToken = token;
        } else if (path.startsWith('/register') == true) {
          registrationToken = token;
        }
      }
    }
  }
}
