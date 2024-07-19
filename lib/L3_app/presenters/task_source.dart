// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/task.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/text.dart';
import '../extra/services.dart';
import '../usecases/task_source.dart';
import 'source.dart';

extension TaskSourcePresenter on Task {
  Widget get go2SourceTitle {
    return Row(
      children: [
        if (source != null) ...[
          source!.type.icon(),
          const SizedBox(width: P),
        ],
        BaseText(loc.task_go2source_title, color: mainColor, maxLines: 1),
      ],
    );
  }
}
