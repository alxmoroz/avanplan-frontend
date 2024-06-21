// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/tariff.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/images.dart';

extension TariffOptionPresenter on TariffOption {
  Widget get icon {
    return code.startsWith(TOCode.TASKS)
        ? const TasksIcon()
        : [TOCode.FILE_STORAGE, 'FS_VOLUME'].contains(code)
            ? const FileStorageIcon()
            : [TOCode.TEAM, 'USERS_COUNT'].contains(code)
                ? const PeopleIcon()
                : const FeaturesIcon();
  }

  Widget get image => MTImage('fs_${code.toLowerCase()}', width: P8, height: P8);
}
