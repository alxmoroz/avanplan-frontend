// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../extra/platform.dart';
import '../extra/services.dart';

//TODO: настройку адресов вынести на бэк. Можно хранить как для типа источника импорта, например.
String get _docsHost => 'https://moroz.team';
String get docsUrlPath => '$_docsHost/gercules/docs/${Intl.getCurrentLocale()}';

String get _contactUsMailAddress => 'hello@gercul.es';
String get _contactUsBody => '%0D%0A-----%0D%0A${loc.app_title} ${settingsController.appVersion}%0D%0A$deviceModelName%0D%0A$deviceSystemInfo';
String get contactUsMailSample => 'mailto:$_contactUsMailAddress?subject=${loc.contact_us_mail_subject}&body=$_contactUsBody';
