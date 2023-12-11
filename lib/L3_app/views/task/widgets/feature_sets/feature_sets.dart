// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/page.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../quiz/abstract_quiz_controller.dart';
import '../../../quiz/header.dart';
import '../../../quiz/next_button.dart';
import '../../controllers/feature_sets_controller.dart';
import '../../controllers/task_controller.dart';

Future showFeatureSetsDialog(TaskController controller) async => await showMTDialog<void>(FeatureSetsDialog(FeatureSetsController(controller)));

class _FSBody extends StatelessWidget {
  const _FSBody(this._controller, {this.shrinkWrap = true});
  final FeatureSetsController _controller;
  final bool shrinkWrap;

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
      builder: (_) => MTShadowed(
        topPaddingIndent: 0,
        bottomShadow: true,
        child: ListView(
          shrinkWrap: shrinkWrap,
          children: [
            MTListSection(titleText: loc.feature_sets_always_on_label),
            MTCheckBoxTile(
              leading: MTImage(ImageName.fs_task_list.name, width: P8, height: P7),
              title: loc.feature_set_tasklist_title,
              description: loc.feature_set_tasklist_description,
              value: true,
              bottomDivider: false,
            ),
            MTListSection(titleText: loc.feature_sets_available_label),
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
          ],
        ),
      ),
    );
  }
}

class FSQuizArgs {
  FSQuizArgs(this._controller, this._qController);
  final FeatureSetsController _controller;
  final AbstractQuizController _qController;
}

class FeatureSetsQuizRouter extends MTRouter {
  @override
  String get path => '/projects/create/feature_sets';

  FSQuizArgs? get _args => rs!.arguments as FSQuizArgs?;

  @override
  Widget? get page => _args != null ? FeatureSetsQuizView(_args!) : null;

  // TODO: если будет инфа об айдишнике проекта, то можем показывать сам проект
  @override
  RouteSettings? get settings => _args != null ? rs : const RouteSettings(name: '/projects');

  @override
  String get title => '${(rs!.arguments as FSQuizArgs?)?._controller.project.viewTitle ?? ''} | ${loc.feature_sets_title}';
}

class FeatureSetsQuizView extends StatelessWidget {
  const FeatureSetsQuizView(this._args);
  final FSQuizArgs _args;

  FeatureSetsController get _controller => _args._controller;
  AbstractQuizController get _qController => _args._qController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: QuizHeader(_qController),
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTAdaptive(child: _FSBody(_controller, shrinkWrap: false)),
        ),
        bottomBar: MTAppBar(
          isBottom: true,
          middle: QuizNextButton(
            _qController,
            loading: _controller.project.loading,
            margin: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}

class FeatureSetsDialog extends StatelessWidget {
  const FeatureSetsDialog(this._controller);
  final FeatureSetsController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTToolBar(titleText: loc.feature_sets_title),
      body: _FSBody(_controller),
      bottomBar: MTButton.main(
        titleText: loc.save_action_title,
        onTap: _controller.save,
      ),
    );
  }
}
