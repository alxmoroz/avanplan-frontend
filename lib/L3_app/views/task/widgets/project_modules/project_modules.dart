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
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/page.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_tree.dart';
import '../../../quiz/abstract_task_quiz_route.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../../workspace/ws_controller.dart';
import '../../../workspace/ws_features_dialog.dart';
import '../../controllers/create_project_quiz_controller.dart';
import '../../controllers/project_modules_controller.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/project_modules.dart';

Future projectModulesDialog(TaskController tc) async => await showMTDialog(_ProjectModulesDialog(tc));

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
  const _ProjectModulesBody(this._tc, {this.footer});
  final TaskController _tc;
  final Widget? footer;

  ProjectModulesController get _pmc => _tc.projectModulesController;
  Task get _project => _tc.task;

  static const _iconSize = 50.0;
  Widget _image(String code) => MTImage('fs_${code.toLowerCase()}', width: _iconSize, height: _iconSize);

  Future _selectFeatures() async {
    await wsFeatures(WSController(wsIn: _project.ws));
    _pmc.reload();
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
            itemCount: _pmc.checks.length,
            itemBuilder: (_, index) {
              final pm = _pmc.enabledProjectOptions.elementAt(index);
              return MTCheckBoxTile(
                leading: _image(pm.code),
                title: pm.title,
                description: pm.subtitle,
                value: _pmc.checks[index],
                bottomDivider: index < _pmc.checks.length - 1,
                dividerIndent: _iconSize + P5,
                onChanged: _tc.onChanged(index),
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

class _ProjectModulesQuizView extends StatefulWidget {
  const _ProjectModulesQuizView(this._qController);
  final CreateProjectQuizController _qController;

  @override
  State<StatefulWidget> createState() => _ProjectModulesQuizViewState();
}

class _ProjectModulesQuizViewState extends State<_ProjectModulesQuizView> {
  late final ScrollController scrollController;

  CreateProjectQuizController get _qController => widget._qController;
  TaskController get _tc => _qController.taskController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qHeader = QuizHeader(_qController);
    return Observer(
      builder: (_) => MTPage(
        navBar: qHeader,
        body: MTAdaptive(
          child: _ProjectModulesBody(
            _tc,
            footer: QuizNextButton(
              _qController,
              loading: _tc.task.loading,
              margin: const EdgeInsets.symmetric(vertical: P3),
            ),
          ),
        ),
        scrollController: scrollController,
        scrollOffsetTop: qHeader.preferredSize.height,
      ),
    );
  }
}

class _ProjectModulesDialog extends StatelessWidget {
  const _ProjectModulesDialog(this._tc);
  final TaskController _tc;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.project_modules_title),
      minBottomPadding: P3,
      body: _ProjectModulesBody(
        _tc,
        footer: MTButton.main(
          titleText: loc.action_save_title,
          margin: const EdgeInsets.only(top: P3),
          onTap: () async {
            Navigator.of(context).pop();
            await _tc.setupProjectModules();
            tasksMainController.refreshUI();
          },
        ),
      ),
    );
  }
}
