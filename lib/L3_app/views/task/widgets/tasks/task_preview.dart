// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../_base/loader_screen.dart';
import '../../task_view.dart';
import '../details/task_description_field.dart';
import '../details/task_details.dart';
import '../header/task_header.dart';

class TaskPreview extends TaskView {
  const TaskPreview(super.controller, {super.key});

  @override
  State<TaskPreview> createState() => _State();
}

class _State extends TaskViewState<TaskPreview> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => controller.loading
          ? LoaderScreen(controller, isDialog: true)
          : MTDialog(
              key: widget.key,
              topBar: MTTopBar(middle: toolbarTitle),
              body: ListView(
                children: [
                  TaskHeader(controller),
                  if (task.hasDescription) TaskDescriptionField(controller, padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P2)),
                  MTAdaptive(child: TaskDetails(controller)),
                ],
              ),
              scrollController: scrollController,
              scrollOffsetTop: headerHeight,
              onScrolled: onScrolled,
            ),
    );
  }
}
