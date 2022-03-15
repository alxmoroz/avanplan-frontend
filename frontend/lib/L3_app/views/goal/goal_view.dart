// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_field.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/goal_presenter.dart';
import '../base/tf_annotation.dart';
import 'goal_controller.dart';

class GoalView extends StatefulWidget {
  static String get routeName => 'goal';

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  GoalController get _controller => goalController;

  @override
  void initState() {
    _controller.initState(context, tfaList: [
      TFAnnotation('title', label: loc.common_title),
      TFAnnotation('description', label: loc.common_description, needValidate: false),
      // TODO: пикер для даты
      TFAnnotation('dueDate', label: loc.common_due_date),
    ]);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code) => MTTextField(
        controller: _controller.controllers[code],
        label: _controller.tfAnnoForCode(code).label,
        error: _controller.tfAnnoForCode(code).errorText,
      );

  List<Widget> editModeElements() {
    return [
      textFieldForCode('title'),
      textFieldForCode('description'),
      textFieldForCode('dueDate'),
      SizedBox(height: onePadding),
      Button(
        loc.btn_save_title,
        _controller.validated ? _controller.saveGoal : null,
        titleColor: _controller.validated ? mainColor : borderColor,
      ),
    ];
  }

  List<Widget> viewModeElements() {
    return [
      // SmallText(goalController.goal?.description ?? ''),
      if (_controller.goal!.etaDateStr.isNotEmpty) H3('${_controller.goal!.etaDateStr}'),
      Expanded(
        child: ListView.builder(
          itemBuilder: taskBuilder,
          itemCount: _controller.goal!.tasks.length,
        ),
      ),
      SizedBox(height: onePadding),
    ];
  }

  Widget taskBuilder(BuildContext context, int index) {
    final task = goalController.goal!.tasks.elementAt(index);
    return ListTile(
      title: NormalText(task.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    //TODO: возможно, будет лучше Cupertino
    return Observer(
      builder: (_) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: cardBackgroundColor.resolve(context),
          elevation: 7,
          title: H3(_controller.goal?.title ?? loc.goal_new_title),
        ),
        body: Container(
          color: backgroundColor.resolve(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(height: onePadding),
              if (_controller.editMode) ...editModeElements(),
              if (!_controller.editMode) ...viewModeElements(),
            ],
          ),
        ),
      ),
    );
  }
}
