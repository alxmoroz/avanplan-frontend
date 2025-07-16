// Copyright (c) 2025. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../L1_domain/entities/task.dart';
import '../components/constants.dart';
import '../components/icons.dart';

extension TaskCreationMethodPresenter on TaskCreationMethod {
  String get actionTitle => Intl.message('create_${name.toLowerCase()}_action_title');
  String get actionDescription => Intl.message('create_${name.toLowerCase()}_action_description');
  String get actionDescriptionShort => Intl.message('create_${name.toLowerCase()}_action_description_short');

  Widget btnIcon({double size = DEF_TAPPABLE_ICON_SIZE}) =>
      {
        TaskCreationMethod.BOARD: BoardIcon(size: size),
        TaskCreationMethod.LIST: ListIcon(size: size),
        TaskCreationMethod.PROJECT: ProjectsIcon(size: size),
        TaskCreationMethod.TEMPLATE: TemplateIcon(size: size),
        TaskCreationMethod.IMPORT: ImportIcon(size: size),
      }[this] ??
      const SizedBox();
}
