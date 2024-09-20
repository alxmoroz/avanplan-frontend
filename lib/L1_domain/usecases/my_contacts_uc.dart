// Copyright (c) 2024. Alexandr Moroz

import '../entities/user_contact.dart';
import '../repositories/abs_api_repo.dart';

class MyContactsUC {
  const MyContactsUC(this.repo);

  final AbstractApiRepo<UserContact, UserContact> repo;

  Future<Iterable<UserContact>> getAll() async => await repo.getAll();
  Future<UserContact?> save(UserContact contact) async => await repo.save(contact);
  Future<UserContact?> delete(UserContact contact) async => await repo.delete(contact);
}
