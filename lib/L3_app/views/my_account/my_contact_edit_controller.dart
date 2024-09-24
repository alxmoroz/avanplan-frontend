// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';

import '../../../L1_domain/entities/user_contact.dart';
import '../../components/constants.dart';
import '../../components/field_data.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';
import 'usecases/contacts.dart';

enum ContactFCode { value, description }

class MyContactEditController extends EditController {
  MyContactEditController(this._contactIn) {
    initState(fds: [
      MTFieldData(ContactFCode.value.index, text: _contactIn.value),
      MTFieldData(ContactFCode.description.index, text: _contactIn.description),
    ]);
  }
  final UserContact _contactIn;

  UserContact get contact => myAccountController.contacts.firstWhereOrNull((c) => c.id == _contactIn.id) ?? _contactIn;

  Timer? _textEditTimer;

  Future<bool> _saveField(ContactFCode code) async {
    updateField(code.index, loading: true);

    final saved = (await myAccountController.saveContact(contact)) != null;

    updateField(code.index, loading: false);
    return saved;
  }

  Future _setValue(String str) async {
    str = str.trim();
    final oldValue = contact.value;
    if (oldValue != str && str.isNotEmpty) {
      contact.value = str;
      if (!(await _saveField(ContactFCode.value))) {
        contact.value = oldValue;
      }
    }
  }

  Future _setDescription(String str) async {
    str = str.trim();
    final oldValue = contact.description;
    if (oldValue != str) {
      contact.description = str;
      if (!(await _saveField(ContactFCode.description))) {
        contact.description = oldValue;
      }
    }
  }

  void _editTextWrapper(String str, Function(String str) setTextCallback) {
    if (_textEditTimer != null) {
      _textEditTimer!.cancel();
    }
    _textEditTimer = Timer(TEXT_SAVE_DELAY_DURATION, () => setTextCallback(str));
  }

  void setValue(String str) => _editTextWrapper(str, _setValue);
  void setDescription(String str) => _editTextWrapper(str, _setDescription);

  Future delete() async => await myAccountController.deleteContact(contact);
}
