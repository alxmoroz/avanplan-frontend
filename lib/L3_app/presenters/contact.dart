// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../L1_domain/entities/abs_contact.dart';
import '../components/colors_base.dart';
import '../components/constants.dart';
import '../components/dialog.dart';
import '../components/icons.dart';
import '../components/list_tile.dart';
import '../components/text.dart';
import '../components/toolbar.dart';
import '../extra/clipboard.dart';

final _emailRx = RegExp(r'^.+@.+\..+');
final _phoneRx = RegExp(r'^\+?\d{6,15}');

extension ContactParserPresenter on AbstractContact {
  String get _email => value.replaceFirst('mailto:', '');
  bool get _mayBeEmail => value.startsWith('mailto:') || _emailRx.hasMatch(_email);
  String get _phoneNumber => value.replaceFirst('tel:', '').replaceAll(RegExp(r'[^+\d]'), '');
  bool get _mayBePhone => value.startsWith('tel:') || _phoneRx.hasMatch(_phoneNumber);

  Widget get icon {
    return _mayBeEmail
        ? const MailIcon()
        : _mayBePhone
            ? const PhoneIcon()
            : const WebIcon();
  }

  String get url {
    return _mayBeEmail
        ? 'mailto:$_email'
        : _mayBePhone
            ? 'tel:$_phoneNumber'
            : value;
  }

  Future tap(BuildContext context) async {
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    } else {
      showMTDialog(_ContactDialog(this), maxWidth: SCR_XS_WIDTH);
    }
  }
}

class _ContactDialog extends StatelessWidget {
  const _ContactDialog(this._contact);
  final AbstractContact _contact;

  Future _tap(BuildContext context) async {
    Navigator.of(context).pop();
    await copyToClipboard(context, _contact.value);
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: const MTAppBar(showCloseButton: true, color: b2Color),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MTListTile(
            middle: H3(_contact.value, maxLines: 2),
            trailing: const CopyIcon(),
            bottomDivider: false,
            onTap: () => _tap(context),
          ),
        ],
      ),
    );
  }
}
