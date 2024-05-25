// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../projects/create_project_quiz_controller.dart';
import '../../../quiz/abstract_task_quiz_route.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/feature_sets_controller.dart';
import '../../controllers/task_controller.dart';

Future featureSetsDialog(TaskController controller) async => await showMTDialog<void>(_FeatureSetsDialog(controller));

class FeatureSetsQuizRoute extends AbstractTaskQuizRoute {
  static String get staticBaseName => 'feature_sets';

  FeatureSetsQuizRoute({required super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, state) => _FeatureSetsQuizView(state.extra as CreateProjectQuizController),
        );
}

class _FSBody extends StatelessWidget {
  const _FSBody(this._controller, {this.footer});
  final FeatureSetsController _controller;
  final Widget? footer;

  static const _iconSize = P8;
  Widget _icon(int index) => MTImage(
        [
          ImageName.fs_analytics,
          ImageName.fs_team,
          ImageName.fs_goals,
          ImageName.fs_task_board,
          ImageName.fs_estimates,
        ][index]
            .name,
        width: _iconSize,
        height: _iconSize,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          MTListGroupTitle(titleText: loc.feature_sets_always_on_label),
          MTCheckBoxTile(
            leading: MTImage(ImageName.fs_task_list.name, width: P8, height: P7),
            title: loc.feature_set_tasklist_title,
            description: loc.feature_set_tasklist_description,
            value: true,
            bottomDivider: false,
          ),
          MTListGroupTitle(titleText: loc.feature_sets_available_label),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _controller.checks.length,
            itemBuilder: (_, index) {
              final fs = refsController.featureSets.elementAt(index);
              final onChanged = _controller.onChanged(index);
              return MTCheckBoxTile(
                leading: _icon(index),
                title: fs.title,
                description: fs.description,
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

class _FeatureSetsQuizView extends StatelessWidget {
  const _FeatureSetsQuizView(this._qController);
  final CreateProjectQuizController _qController;

  FeatureSetsController get _fsController => _qController.taskController.featureSetsController;

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
            child: _FSBody(
              _fsController,
              footer: QuizNextButton(
                _qController,
                loading: _fsController.project.loading,
                margin: const EdgeInsets.symmetric(vertical: P3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureSetsDialog extends StatelessWidget {
  const _FeatureSetsDialog(this._controller);
  final TaskController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.feature_sets_title),
      body: _FSBody(
        _controller.featureSetsController,
        footer: MTButton.main(
          titleText: loc.save_action_title,
          margin: EdgeInsets.only(top: P3, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
          onTap: _controller.featureSetsController.save,
        ),
      ),
    );
  }
}
