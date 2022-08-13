// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/icons.dart';
import '../../components/mt_action.dart';
import '../../extra/services.dart';

class TaskAddAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MTAction(
      hint: loc.task_list_empty_title,
      title: loc.task_title_new,
      icon: plusIcon(context, size: 24),
      onPressed: () => taskViewController.addTask(context),
    );
  }
}
