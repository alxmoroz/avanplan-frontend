// Copyright (c) 2023. Alexandr Moroz

import '../../L2_data/repositories/communications_repo.dart';
import '../extra/services.dart';
import '../presenters/communications.dart';

Future<bool> mailUs({String? subject, String? text}) async {
  return await sendMail(
    subject ?? loc.contact_us_mail_subject,
    appTitle,
    accountController.me?.id,
    text: text,
  );
}
