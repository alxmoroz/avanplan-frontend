// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter_dotenv/flutter_dotenv.dart';

String? get apiPath => dotenv.maybeGet('API_PATH');
String? get appleAuthRedirectPath => dotenv.maybeGet('APPLE_AUTH_REDIRECT_PATH');
String get visibleApiHost => Uri.tryParse(apiPath ?? '')?.host ?? '';
