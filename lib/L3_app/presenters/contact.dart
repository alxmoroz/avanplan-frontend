// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../L1_domain/entities/abs_contact.dart';
import '../../L1_domain/entities_extensions/contact.dart';
import '../components/constants.dart';
import '../components/dialog.dart';
import '../components/icons.dart';
import '../views/person/contact_no_type_details_dialog.dart';

extension ContactParserPresenter on AbstractContact {
  Widget get icon {
    return mayBeEmail
        ? const MailIcon()
        : mayBePhone
            ? const PhoneIcon()
            : mayBeUrl
                ? const WebIcon()
                : const DescriptionIcon();
  }

  String get url {
    return mayBeEmail
        ? 'mailto:$email'
        : mayBePhone
            ? 'tel:$phoneNumber'
            : value;
  }

  Future tap(BuildContext context) async {
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    } else {
      showMTDialog(PersonContactNoTypeDetailsDialog(this), maxWidth: SCR_XS_WIDTH);
    }
  }
}
