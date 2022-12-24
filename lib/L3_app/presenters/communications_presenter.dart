// Copyright (c) 2022. Alexandr Moroz

import '../../L2_data/repositories/platform.dart';
import '../extra/services.dart';

const _host = 'https://moroz.team';
const legalConfidentialPath = '$_host/legal/confidential';
const legalRulesPath = '$_host/avanplan/legal/rules';
const docsPath = '$_host/avanplan/docs/';

String get _contactUsMailAddress => 'hello@avanplan.ru';
String get _contactUsBody => '%0D%0A-----'
    '%0D%0A${loc.app_title} ${settingsController.appVersion}'
    '%0D%0A$deviceModelName'
    '%0D%0A$deviceSystemInfo'
    '%0D%0AUserId:${accountController.user?.id}';
String get contactUsMailSample => 'mailto:$_contactUsMailAddress?subject=${loc.contact_us_mail_subject}&body=$_contactUsBody';
