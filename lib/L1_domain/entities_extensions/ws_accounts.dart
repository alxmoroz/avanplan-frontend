// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/workspace.dart';

extension WSAccounts on Workspace {
  num get welcomeGiftAmount => mainAccount.incomingOperations.firstWhereOrNull((op) => op.basis == 'WELCOME_GIFT')?.amount ?? 0;
}
