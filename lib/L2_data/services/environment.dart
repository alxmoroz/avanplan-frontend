// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter_dotenv/flutter_dotenv.dart';

const _STAGE_PROD = 'prod';
String get _stage => dotenv.maybeGet('STAGE') ?? _STAGE_PROD;
bool get _isProd => _stage == _STAGE_PROD;

String get _apiHost => dotenv.maybeGet('API_HOST') ?? 'https://avanplan.ru';
String get apiKey => dotenv.maybeGet('API_KEY') ?? '';
String get apiPath => '$_apiHost/api';
String get appleOauthRedirectUri => _apiHost;
String get yandexOauthRedirectUri => '$_apiHost/yandex_oauth';
String get visibleApiHost => _isProd ? '' : Uri.parse(_apiHost).host;
