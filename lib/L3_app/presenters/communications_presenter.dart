// Copyright (c) 2022. Alexandr Moroz

import '../../L2_data/services/platform.dart';
import '../extra/services.dart';

const _host = 'https://moroz.team';
const legalConfidentialPath = '$_host/legal/confidential';
const legalRulesPath = '$_host/avanplan/legal/rules';
const docsPath = '$_host/avanplan/docs/';

String get _contactUsMailAddress => 'hello@avanplan.ru';
String get _contactUsBody => '\r\n-----'
    '\r\n${loc.app_title} ${settingsController.appVersion}'
    '\r\n$deviceModelName'
    '\r\n$deviceSystemInfo'
    '\r\nUserId:${accountController.user?.id}';
String get contactUsMailSample => Uri.encodeFull('mailto:$_contactUsMailAddress?subject=${loc.contact_us_mail_subject}&body=$_contactUsBody');
