// Copyright (c) 2024. Alexandr Moroz

import '../../../extra/services.dart';
import '../account_controller.dart';

extension ContactsUC on AccountController {
  Future loadContacts() async {
    await load(() async {
      setContacts(await myContactsUC.getAll());
    });
  }
}
