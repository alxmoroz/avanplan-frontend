// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/tariff_option.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/page.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_tree.dart';
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../quiz/abstract_task_quiz_route.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../../workspace/ws_controller.dart';
import '../../../workspace/ws_features_dialog.dart';
import '../../controllers/create_project_quiz_controller.dart';
import '../../controllers/project_modules_controller.dart';
import '../../controllers/task_controller.dart';

Future projectModulesDialog(TaskController controller) async => await showMTDialog<void>(_ProjectModulesDialog(controller));

class ProjectModulesQuizRoute extends AbstractTaskQuizRoute {
  static String get staticBaseName => 'modules';

  ProjectModulesQuizRoute({required super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, state) => _ProjectModulesQuizView(state.extra as CreateProjectQuizController),
        );
}

class _ProjectModulesBody extends StatelessWidget {
  const _ProjectModulesBody(this._controller, {this.footer});
  final ProjectModulesController _controller;
  final Widget? footer;

  Task get _project => _controller.project;

  static const _iconSize = 50.0;
  Widget _image(String code) => MTImage('fs_${code.toLowerCase()}', width: _iconSize, height: _iconSize);

  Future _selectFeatures() async {
    await wsFeatures(WSController(wsIn: _project.ws));
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          MTListGroupTitle(titleText: loc.project_modules_always_on_label),
          MTCheckBoxTile(
            leading: _image(TOCode.TASKS),
            title: loc.tariff_option_tasks_title,
            description: loc.tariff_option_tasks_subtitle,
            value: true,
            bottomDivider: false,
          ),
          MTListGroupTitle(titleText: loc.project_modules_available_label),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _controller.checks.length,
            itemBuilder: (_, index) {
              final pm = _controller.enabledProjectOptions.elementAt(index);
              return MTCheckBoxTile(
                leading: _image(pm.code),
                title: pm.title,
                description: pm.subtitle,
                value: _controller.checks[index],
                bottomDivider: index < _controller.checks.length - 1,
                dividerIndent: _iconSize + P5,
                onChanged: _controller.onChanged(index),
              );
            },
          ),
          if (!_project.ws.allProjectOptionsUsed)
            MTListTile(
              leading: const FeaturesIcon(size: _iconSize),
              middle: BaseText.medium(loc.promo_features_subscribe_title, color: mainColor),
              trailing: const ChevronIcon(),
              margin: const EdgeInsets.only(top: P3),
              bottomDivider: false,
              onTap: _selectFeatures,
            ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}

class _ProjectModulesQuizView extends StatelessWidget {
  const _ProjectModulesQuizView(this._qController);
  final CreateProjectQuizController _qController;

  ProjectModulesController get _pmController => _qController.taskController.projectModulesController;

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
            child: _ProjectModulesBody(
              _pmController,
              footer: QuizNextButton(
                _qController,
                loading: _pmController.project.loading,
                margin: const EdgeInsets.symmetric(vertical: P3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectModulesDialog extends StatelessWidget {
  const _ProjectModulesDialog(this._controller);
  final TaskController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.project_modules_title),
      body: _ProjectModulesBody(
        _controller.projectModulesController,
        footer: MTButton.main(
          titleText: loc.save_action_title,
          margin: EdgeInsets.only(top: P3, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
          onTap: () async {
            Navigator.of(context).pop();
            await _controller.projectModulesController.setup();
            tasksMainController.refreshUI();
          },
        ),
      ),
    );
  }
}
