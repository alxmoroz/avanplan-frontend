// Copyright (c) 2022. Alexandr Moroz

class Invitation {
  Invitation(this.taskId, this.roleId, this.activationsCount, this.expiresOn);
  final int taskId;
  final int roleId;
  final int activationsCount;
  final DateTime expiresOn;
}
