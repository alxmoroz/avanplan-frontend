// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/abs_contact.dart';
import '../../../L1_domain/entities_extensions/contact.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/toolbar.dart';
import '../../presenters/contact.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../app/clipboard.dart';
import '../app/services.dart';

Future showPersonContactsDialog(String personName, List<AbstractContact> contacts) async {
  await showMTDialog(_PersonContactsDialog(personName, contacts));
}

class _PersonContactsDialog extends StatelessWidget {
  const _PersonContactsDialog(this._personName, this._contacts);
  final String _personName;
  final List<AbstractContact> _contacts;

  static const _dividerIndent = P5 + DEF_TAPPABLE_ICON_SIZE;

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
      topBar: MTTopBar(
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
            color: b3Color,
            leading: c.icon,
            middle: c.hasDescription ? SmallText(c.description, maxLines: 1) : value,
            subtitle: c.hasDescription ? value : null,
            trailing: c.other ? const CopyIcon() : const LinkOutIcon(),
            bottomDivider: index < _contacts.length - 1,
            dividerIndent: _dividerIndent,
            onTap: () => _tap(context, c),
          );
        },
      ),
    );
  }
}
