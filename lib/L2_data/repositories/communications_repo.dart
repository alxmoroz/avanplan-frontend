// Copyright (c) 2022. Alexandr Moroz

import 'package:url_launcher/url_launcher_string.dart';

import '../../L3_app/extra/services.dart';
import '../services/platform.dart';

const _host = 'https://moroz.team';
const _contactUsMailAddress = 'hello@avanplan.ru';

const legalConfidentialPath = '$_host/legal/confidential';
const legalRulesPath = '$_host/avanplan/legal/rules';
const docsPath = '$_host/avanplan/docs/';

Future<bool> sendMail(String subject, String title, int? userId, [String description = '']) async {
  final body = '\r\n-----'
      '\r\n$title'
      '\r\n$deviceModelName'
      '\r\n$deviceSystemInfo'
      '\r\nUserId:$userId'
      '\r\n$description';

  final url = Uri.encodeFull('mailto:$_contactUsMailAddress?subject=${loc.contact_us_mail_subject}&body=$body');
  return await launchUrlString(url);
}
