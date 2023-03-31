// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../components/colors.dart';

extension TaskColorPresenter on Task {
  Color get bgColor => backgroundColor;
}
