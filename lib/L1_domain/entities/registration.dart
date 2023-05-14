// Copyright (c) 2022. Alexandr Moroz

class RegistrationRequest {
  RegistrationRequest(this.name, this.email, {this.invitationToken});
  final String name;
  final String email;
  final String? invitationToken;
}
