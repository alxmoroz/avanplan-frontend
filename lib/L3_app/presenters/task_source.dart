// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/ws_sources.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/text.dart';
import '../extra/services.dart';
import 'source.dart';

extension TaskSourcePresenter on Task {
  Widget get go2SourceTitle {
    final _source = ws.sourceForId(taskSource?.sourceId);
    return Row(
      children: [
        if (_source != null) ...[
          _source.type.icon,
          const SizedBox(width: P_2),
        ],
        BaseText(loc.task_go2source_title, color: mainColor),
        const SizedBox(width: P_2),
        const LinkOutIcon(),
      ],
    );
  }
}
