// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/tariff.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/page.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/project_features.dart';
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../projects/create_project_quiz_controller.dart';
import '../../../quiz/abstract_task_quiz_route.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/project_feature_controller.dart';
import '../../controllers/task_controller.dart';

Future projectFeaturesDialog(TaskController controller) async => await showMTDialog<void>(_ProjectFeaturesDialog(controller));

class ProjectFeaturesQuizRoute extends AbstractTaskQuizRoute {
  static String get staticBaseName => 'features';

  ProjectFeaturesQuizRoute({required super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, state) => _ProjectFeaturesQuizView(state.extra as CreateProjectQuizController),
        );
}

class _ProjectFeaturesBody extends StatelessWidget {
  const _ProjectFeaturesBody(this._controller, {this.footer});
  final ProjectFeatureController _controller;
  final Widget? footer;

  static const _iconSize = P8;
  Widget _image(String code) => MTImage('fs_${code.toLowerCase()}', width: _iconSize, height: _iconSize);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          MTListGroupTitle(titleText: loc.project_features_always_on_label),
          MTCheckBoxTile(
            leading: _image(TOCode.TASKS),
            title: loc.tariff_option_tasks_title,
            description: loc.tariff_option_tasks_subtitle,
            value: true,
            bottomDivider: false,
          ),
          MTListGroupTitle(titleText: loc.project_features_available_label),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _controller.checks.length,
            itemBuilder: (_, index) {
              final fs = _controller.project.availableFeatures.elementAt(index);
              final onChanged = _controller.onChanged(index);
              return MTCheckBoxTile(
                leading: _image(fs.code),
                title: fs.title,
                description: fs.subtitle,
                value: _controller.checks[index],
                bottomDivider: index < _controller.checks.length - 1,
                dividerIndent: _iconSize + P5,
                onChanged: onChanged,
              );
            },
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}

class _ProjectFeaturesQuizView extends StatelessWidget {
  const _ProjectFeaturesQuizView(this._qController);
  final CreateProjectQuizController _qController;

  ProjectFeatureController get _pfController => _qController.taskController.projectFeaturesController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: QuizHeader(_qController),
        leftBar: isBigScreen(context) ? LeftMenu(leftMenuController) : null,
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTAdaptive(
            child: _ProjectFeaturesBody(
              _pfController,
              footer: QuizNextButton(
                _qController,
                loading: _pfController.project.loading,
                margin: const EdgeInsets.symmetric(vertical: P3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectFeaturesDialog extends StatelessWidget {
  const _ProjectFeaturesDialog(this._controller);
  final TaskController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.project_features_title),
      body: _ProjectFeaturesBody(
        _controller.projectFeaturesController,
        footer: MTButton.main(
          titleText: loc.save_action_title,
          margin: EdgeInsets.only(top: P3, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
          onTap: () async {
            Navigator.of(context).pop();
            await _controller.projectFeaturesController.setup();
            tasksMainController.refreshUI();
          },
        ),
      ),
    );
  }
}
