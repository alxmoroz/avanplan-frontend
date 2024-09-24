// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/user_contact.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/user_contact.dart';
import '../services/api.dart';

class MyContactsRepo extends AbstractApiRepo<UserContact, UserContact> {
  o_api.MyContactsApi get _myContactsApi => openAPI.getMyContactsApi();

  @override
  Future<Iterable<UserContact>> getAll() async => (await _myContactsApi.myContacts()).data?.map((c) => c.userContact) ?? [];

  @override
  Future<UserContact?> save(UserContact data) async {
    return (await _myContactsApi.upsertMyContact(
            userContactUpsert: (o_api.UserContactUpsertBuilder()
                  ..id = data.id
                  ..userId = data.userId
                  ..value = data.value
                  ..description = data.description)
                .build()))
        .data
        ?.userContact;
  }

  @override
  Future<UserContact?> delete(UserContact data) async {
    final response = await _myContactsApi.deleteMyContact(
      userContactId: data.id!,
    );
    return response.data == true ? data : null;
  }
}
