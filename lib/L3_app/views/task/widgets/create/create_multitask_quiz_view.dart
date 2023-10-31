// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L2_data/services/platform.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/images.dart';
import '../../../../components/page.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../quiz/header.dart';
import '../../../quiz/next_button.dart';
import '../../../quiz/quiz_controller.dart';
import '../../controllers/create_multi_task_controller.dart';
import '../../controllers/task_controller.dart';
import '../../task_view.dart';
import '../../widgets/create/create_task_button.dart';

class CreateMultiTaskQuizArgs {
  CreateMultiTaskQuizArgs(this._controller, this._qController);
  final TaskController _controller;
  final QuizController _qController;
}

class CreateMultiTaskQuizView extends TaskView {
  CreateMultiTaskQuizView(this._args) : super(_args._controller);
  final CreateMultiTaskQuizArgs _args;

  static String get routeName => '/create_multitask_quiz';
  static String title(CreateMultiTaskQuizArgs _args) => '${_args._controller.task.viewTitle}';

  @override
  State<CreateMultiTaskQuizView> createState() => _CreateMultiTaskQuizViewState();
}

class _CreateMultiTaskQuizViewState extends State<CreateMultiTaskQuizView> {
  late final CreateMultiTaskController controller;

  QuizController get qController => widget._args._qController;
  TaskController get parentTaskController => widget._args._controller;

  @override
  void initState() {
    controller = CreateMultiTaskController(parentTaskController);
    super.initState();
  }

  Widget get addButton => CreateTaskButton(
        parentTaskController,
        type: ButtonType.secondary,
        margin: const EdgeInsets.only(top: P3),
        uf: false,
        onTap: () async => await controller.addTask(),
      );

  Future kbSubmit(String _) async {
    if (MediaQuery.viewInsetsOf(context).bottom == 0) {
      await controller.addTask();
    }
  }

  Widget itemBuilder(BuildContext context, int index) {
    if (index == controller.sortedControllers.length) {
      return addButton;
    } else {
      final tController = controller.sortedControllers.elementAt(index);
      return MTField(
        tController.fData(TaskFCode.title.index),
        value: MTTextField(
          controller: tController.teController(TaskFCode.title.index),
          autofocus: tController.task.isNew,
          margin: EdgeInsets.zero,
          maxLines: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            hintText: tController.titleController.titlePlaceholder,
            hintStyle: const BaseText('', color: f3Color).style(context),
          ),
          style: const BaseText('').style(context),
          onChanged: tController.titleController.editTitle,
          onSubmitted: kbSubmit,
        ),
        padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: isWeb ? P : P_3),
        bottomDivider: index < controller.sortedControllers.length - 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MTPage(
              appBar: quizHeader(context, qController),
              body: SafeArea(
                top: false,
                bottom: false,
                child: MTAdaptive(
                  child: controller.sortedControllers.isNotEmpty
                      ? MTShadowed(
                          bottomShadow: true,
                          child: ListView.builder(
                            itemBuilder: itemBuilder,
                            itemCount: controller.sortedControllers.length + 1,
                          ),
                        )
                      : Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              MTImage(ImageName.empty_tasks.name),
                              H2(loc.task_list_empty_hint, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P6)),
                              addButton,
                            ],
                          ),
                        ),
                ),
              ),
              bottomBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QuizNextButton(
                    qController,
                    margin: EdgeInsets.zero,
                  ),
                ],
              )),
          // if (parent.error != null)
          //   MTErrorSheet(parent.error!, onClose: () {
          //     parent.error = null;
          //     tasksMainController.refreshTasks();
          //   }),
        ],
      ),
    );
  }
}
