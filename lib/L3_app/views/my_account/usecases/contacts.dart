// Copyright (c) 2024. Alexandr Moroz

import '../../../../L1_domain/entities/user_contact.dart';
import '../../app/services.dart';
import '../my_account_controller.dart';

extension ContactsUC on MyAccountController {
  Future loadContacts() async {
    setLoaderScreenLoading();
    await load(() async {
      setContacts(await myContactsUC.getAll());
    });
  }

  Future<UserContact?> saveContact(UserContact contact) async {
    final ec = await myContactsUC.save(contact);
    if (ec != null) {
      if (contact.isNew) {
        contacts.add(ec);
      } else {
        final index = contacts.indexWhere((c) => ec.id == c.id);
        if (index > -1) {
          contacts[index] = ec;
        }
      }
    }
    return ec;
  }

  Future deleteContact(UserContact contact) async {
    contact.loading = true;
    refreshContacts();

    if (await myContactsUC.delete(contact) != null) {
      contacts.remove(contact);
    } else {
      contact.loading = false;
    }

    refreshContacts();
  }
}
