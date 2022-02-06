// Copyright (c) 2022. Alexandr Moroz

import '../../../extra/services.dart';

bool get isTablet => iosInfo.model == 'iPad';
double get sidePadding => isTablet ? 24 : 12;
