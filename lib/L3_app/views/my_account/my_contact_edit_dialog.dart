// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user_contact.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/field.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../components/text_field.dart';
import '../../components/toolbar.dart';
import '../app/services.dart';
import 'my_contact_edit_controller.dart';

Future showMyContactEditDialog({UserContact? contact}) async {
  final cec = MyContactEditController(contact ?? UserContact(value: '', userId: myAccountController.me!.id!));
  await showMTDialog(_MyContactEditDialog(cec));
}

class _MyContactEditDialog extends StatelessWidget {
  const _MyContactEditDialog(this._cec);
  final MyContactEditController _cec;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(
          pageTitle: loc.person_contact_title,
          trailing: _cec.contact.isNew
              ? null
              : MTButton.icon(
                  const DeleteIcon(),
                  onTap: () {
                    Navigator.of(context).pop();
                    _cec.delete();
                  },
                  padding: const EdgeInsets.all(P2),
                ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            MTField(
              _cec.fData(ContactFCode.value.index),
              value: MTTextField(
                controller: _cec.teController(ContactFCode.value.index),
                margin: EdgeInsets.zero,
                maxLines: 2,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: loc.person_contact_placeholder,
                  hintStyle: const H2('', color: f3Color, maxLines: 2).style(context),
                ),
                style: const H2('', maxLines: 2).style(context),
                onChanged: _cec.setValue,
              ),
              padding: const EdgeInsets.symmetric(horizontal: P3),
              color: b2Color,
            ),
            MTField(
              _cec.fData(ContactFCode.description.index),
              value: MTTextField(
                controller: _cec.teController(ContactFCode.description.index),
                autofocus: false,
                margin: EdgeInsets.zero,
                maxLines: 3,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: loc.person_contact_description_placeholder,
                  hintStyle: const BaseText.f3('', maxLines: 3).style(context),
                ),
                style: const BaseText('', maxLines: 3).style(context),
                onChanged: _cec.setDescription,
              ),
              padding: const EdgeInsets.symmetric(horizontal: P3),
              color: b2Color,
            ),
          ],
        ),
        hasKBInput: true,
      ),
    );
  }
}
