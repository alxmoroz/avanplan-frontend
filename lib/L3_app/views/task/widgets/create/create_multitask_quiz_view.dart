// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/images.dart';
import '../../../../components/page.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/router.dart';
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

class CreateMultiTaskQuizRouter extends MTRouter {
  @override
  String get path => '/projects/create/tasks';

  CreateMultiTaskQuizArgs? get _args => rs!.arguments as CreateMultiTaskQuizArgs?;

  @override
  Widget? get page => _args != null ? CreateMultiTaskQuizView(_args!) : null;

  // TODO: если будет инфа об айдишнике проекта, то можем показывать сам проект
  @override
  RouteSettings? get settings => _args != null ? rs : const RouteSettings(name: '/projects');

  @override
  String get title => (rs!.arguments as CreateMultiTaskQuizArgs?)?._controller.task.viewTitle ?? '';
}

class CreateMultiTaskQuizView extends TaskView {
  CreateMultiTaskQuizView(this._args) : super(_args._controller);
  final CreateMultiTaskQuizArgs _args;

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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget get addButton => CreateTaskButton(
        parentTaskController,
        type: ButtonType.secondary,
        margin: const EdgeInsets.only(top: P3),
        uf: false,
        onTap: controller.addTask,
      );

  Widget itemBuilder(BuildContext context, int index) {
    if (index == controller.taskControllers.length) {
      return addButton;
    } else {
      final tController = controller.taskControllers.elementAt(index);
      final fData = tController.fData(TaskFCode.title.index);
      final teController = tController.teController(TaskFCode.title.index);

      final fNode = tController.focusNode(TaskFCode.title.index);
      fNode?.addListener(() => controller.refresh());

      final roText = teController?.text.isNotEmpty == true ? teController!.text : tController.titleController.titlePlaceholder;
      return MTField(
        fData,
        loading: tController.task.loading == true,
        minHeight: P8,
        value: Slidable(
          key: ObjectKey(tController),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(
              onDismissed: () {},
              confirmDismiss: () async => await controller.deleteTask(tController),
            ),
            children: [
              SlidableAction(
                onPressed: (_) async => await controller.deleteTask(tController),
                backgroundColor: dangerColor.resolve(context),
                foregroundColor: b3Color.resolve(context),
                icon: CupertinoIcons.delete,
                label: loc.delete_action_title,
              ),
            ],
          ),
          child: Stack(
            children: [
              MTTextField(
                keyboardType: TextInputType.multiline,
                controller: teController,
                autofocus: index == controller.taskControllers.length - 1,
                margin: const EdgeInsets.symmetric(horizontal: P3),
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: tController.titleController.titlePlaceholder,
                  hintStyle: const BaseText('', color: f3Color).style(context),
                ),
                style: const BaseText('').style(context),
                onChanged: (str) => controller.editTitle(tController, str),
                onSubmitted: (_) => controller.addTask(),
                focusNode: fNode,
              ),
              if (fNode?.hasFocus == false)
                Container(
                  color: b3Color.resolve(context),
                  padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: 1),
                  height: P8,
                  alignment: Alignment.centerLeft,
                  child: BaseText(roText, maxLines: 1),
                ),
            ],
          ),
        ),
        padding: EdgeInsets.zero,
        dividerIndent: P3,
        dividerEndIndent: P3,
        bottomDivider: index < controller.taskControllers.length - 1,
        onSelect: () => controller.setFocus(true, tController),
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
            appBar: QuizHeader(qController),
            body: SafeArea(
              top: false,
              bottom: false,
              child: MTAdaptive(
                child: controller.taskControllers.isNotEmpty
                    ? MTShadowed(
                        bottomShadow: true,
                        child: ListView.builder(
                          itemBuilder: itemBuilder,
                          itemCount: controller.taskControllers.length + 1,
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
            bottomBar: MTAppBar(
              isBottom: true,
              middle: QuizNextButton(qController, margin: EdgeInsets.zero),
            ),
          ),
        ],
      ),
    );
  }
}
