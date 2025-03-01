// Copyright (c) 2024. Alexandr Moroz

import '../../L1_domain/repositories/abs_network_repo.dart';
import '../services/api.dart';

class NetworkRepo extends AbstractNetworkRepo {
  @override
  void setOauthToken(String token) => avanplanApi.setOAuthToken('OAuth2PasswordBearer', token);
}
