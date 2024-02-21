// Copyright (c) 2024. Alexandr Moroz

import 'package:url_launcher/url_launcher_string.dart';

import '../../L3_app/extra/services.dart';
import '../services/platform.dart';

const _host = 'https://moroz.team';
const _contactUsMailAddress = 'hello@avanplan.ru';

const docsPath = '$_host/avanplan/docs/';

const feedbackUrlString = '$_host/avanplan/feedback';
const legalConfidentialUrlString = '$_host/legal/confidential';
const legalRulesUrlString = '$_host/avanplan/legal/rules';
const releaseNotesUrlString = '$_host/avanplan/changelog';
const tariffsUrlString = '$_host/avanplan/tariffs';
const telegramUrlString = 'https://t.me/avanplan';
const vkUrlString = 'https://vk.com/morozteamnews';
const homepageUrlString = '$_host/avanplan';

const _appAppStoreUrlString = 'https://apps.apple.com/app/avanplan/id1661313266';
const _appGooglePlayUrlString = 'https://play.google.com/store/apps/details?id=team.moroz.avanplan';

String get appInstallUrlString => isIOS ? _appAppStoreUrlString : _appGooglePlayUrlString;

Future<bool> sendMail(String subject, String appIdentifier, int? userId, {String? text = ''}) async {
  final body = ''
      '$text'
      '\r\n-----'
      '\r\n$appIdentifier'
      '\r\n$deviceModelName'
      '\r\n$deviceSystemInfo'
      '\r\nUserId:$userId'
      '\r\n';

  final url = Uri.encodeFull('mailto:$_contactUsMailAddress?subject=${loc.contact_us_mail_subject}&body=$body');
  return await launchUrlString(url);
}
