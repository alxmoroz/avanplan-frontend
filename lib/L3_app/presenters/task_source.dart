// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/ws_sources.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/text_widgets.dart';
import '../extra/services.dart';
import 'source.dart';

extension TaskSourcePresenter on Task {
  Widget get go2SourceTitle {
    final _source = ws.sourceForId(taskSource?.sourceId);
    return Row(
      children: [
        const LinkIcon(),
        const SizedBox(width: P_3),
        NormalText(loc.task_go2source_title, color: mainColor),
        if (_source != null) ...[
          const SizedBox(width: P_3),
          _source.type.icon,
        ],
      ],
    );
  }
}
