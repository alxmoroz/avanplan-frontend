// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter_dotenv/flutter_dotenv.dart';

const _STAGE_PROD = 'prod';
String get _stage => dotenv.maybeGet('STAGE') ?? _STAGE_PROD;
bool get _isProd => _stage == _STAGE_PROD;

String get _apiHost => dotenv.maybeGet('API_HOST') ?? 'https://avanplan.ru';
String get apiPath => '$_apiHost/api';
String get appleAuthRedirectPath => _apiHost;
String get visibleApiHost => _isProd ? '' : Uri.parse(_apiHost).host;
