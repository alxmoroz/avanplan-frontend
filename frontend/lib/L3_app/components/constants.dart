// Copyright (c) 2022. Alexandr Moroz

import '../../L3_app/extra/services.dart';

bool get isTablet => iosInfo.model == 'iPad';
double get padding => isTablet ? 24 : 12;
