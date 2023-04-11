// Copyright (c) 2022. Alexandr Moroz

class Registration {
  Registration(this.name, this.email, this.locale, {this.invitationToken});
  final String name;
  final String email;
  final String locale;
  final String? invitationToken;
}
