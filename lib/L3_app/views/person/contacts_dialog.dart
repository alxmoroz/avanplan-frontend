// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/abs_contact.dart';
import '../../../L1_domain/entities_extensions/contact.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/clipboard.dart';
import '../../extra/services.dart';
import '../../presenters/contact.dart';

Future showPersonContactsDialog(String personName, List<AbstractContact> contacts) async {
  await showMTDialog(_PersonContactsDialog(personName, contacts));
}

class _PersonContactsDialog extends StatelessWidget {
  const _PersonContactsDialog(this._personName, this._contacts);
  final String _personName;
  final List<AbstractContact> _contacts;

  void _tap(BuildContext context, AbstractContact contact) {
    Navigator.of(context).pop();
    if (contact.other) {
      copyToClipboard(context, contact.value);
    } else {
      contact.tap(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(
        color: b2Color,
        showCloseButton: true,
        pageTitle: loc.person_contacts_title,
        parentPageTitle: _personName,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _contacts.length,
        itemBuilder: (_, index) {
          final c = _contacts[index];
          final value = BaseText(c.value, maxLines: 1);
          return MTListTile(
            leading: c.icon,
            middle: c.hasDescription ? SmallText(c.description, maxLines: 1) : value,
            subtitle: c.hasDescription ? value : null,
            trailing: c.other ? const CopyIcon() : const LinkOutIcon(),
            bottomDivider: index < _contacts.length - 1,
            dividerIndent: P11,
            onTap: () => _tap(context, c),
          );
        },
      ),
    );
  }
}
