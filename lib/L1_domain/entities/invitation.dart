// Copyright (c) 2022. Alexandr Moroz

class Invitation {
  Invitation(
    this.taskId,
    this.roleId,
    this.expiresOn, {
    this.url,
  });
  final int taskId;
  final int roleId;
  final DateTime expiresOn;
  final String? url;
}
