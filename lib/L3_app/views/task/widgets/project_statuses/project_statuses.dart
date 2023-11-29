// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/page.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../quiz/header.dart';
import '../../../quiz/next_button.dart';
import '../../../quiz/quiz_controller.dart';
import '../../controllers/project_statuses_controller.dart';

Future showProjectStatusesDialog(ProjectStatusesController controller) async {
  await showMTDialog<void>(ProjectStatusesDialog(controller));
  tasksMainController.refreshTasks();
}

class _PSBody extends StatelessWidget {
  const _PSBody(this._controller, {this.shrinkWrap = true});
  final ProjectStatusesController _controller;
  final bool shrinkWrap;

  Widget itemBuilder(BuildContext context, int index) {
    final status = _controller.sortedStatuses.elementAt(index);
    return MTListTile(
      titleText: '$status',
      subtitle: status.description.isNotEmpty ? SmallText(status.description, maxLines: 2) : null,
      trailing: Row(
        children: [
          if (status.closed) ...[const DoneIcon(true, color: f2Color), const SizedBox(width: P)],
          const ChevronIcon(),
        ],
      ),
      loading: status.loading,
      bottomDivider: index < _controller.sortedStatuses.length - 1,
      onTap: () => _controller.edit(status),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        topPaddingIndent: P,
        bottomShadow: true,
        child: ListView.builder(
          shrinkWrap: shrinkWrap,
          itemBuilder: itemBuilder,
          itemCount: _controller.sortedStatuses.length,
        ),
      ),
    );
  }
}

class _CreateStatusButton extends StatelessWidget {
  const _CreateStatusButton(this._controller);
  final ProjectStatusesController _controller;

  @override
  Widget build(BuildContext context) => MTButton.secondary(
        leading: const PlusIcon(),
        titleText: loc.status_create_action_title,
        onTap: _controller.create,
      );
}

class PSQuizArgs {
  PSQuizArgs(this._controller, this._qController);
  final ProjectStatusesController _controller;
  final QuizController _qController;
}

class ProjectStatusesQuizRouter extends MTRouter {
  @override
  String get path => '/projects/create/statuses';

  PSQuizArgs? get _args => rs!.arguments as PSQuizArgs?;

  @override
  Widget? get page => _args != null ? ProjectStatusesQuizView(_args!) : null;

  // TODO: если будет инфа об айдишнике проекта, то можем показывать сам проект
  @override
  RouteSettings? get settings => _args != null ? rs : const RouteSettings(name: '/projects');

  @override
  String get title => '${(rs!.arguments as PSQuizArgs?)?._controller.project.viewTitle ?? ''} | ${loc.status_list_title}';
}

class ProjectStatusesQuizView extends StatelessWidget {
  const ProjectStatusesQuizView(this._args);
  final PSQuizArgs _args;

  ProjectStatusesController get _controller => _args._controller;
  QuizController get _qController => _args._qController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: QuizHeader(_qController),
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTAdaptive(child: _PSBody(_controller, shrinkWrap: false)),
        ),
        bottomBar: MTAppBar(
          isBottom: true,
          height: P8 + P8 + P3,
          middle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CreateStatusButton(_controller),
              const SizedBox(height: P3),
              QuizNextButton(
                _qController,
                loading: _controller.project.loading,
                margin: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectStatusesDialog extends StatelessWidget {
  const ProjectStatusesDialog(this._controller);
  final ProjectStatusesController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTToolBar(titleText: loc.status_list_title),
      body: _PSBody(_controller),
      bottomBar: _CreateStatusButton(_controller),
    );
  }
}
