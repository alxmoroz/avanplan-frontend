// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/toolbar.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../_base/loader_screen.dart';
import '../../../app/services.dart';
import '../../task_view.dart';
import '../details/task_description_field.dart';
import '../details/task_details.dart';
import '../header/task_header.dart';

class RelatedTaskPreview extends TaskView {
  const RelatedTaskPreview(super.controller, {super.key});

  @override
  State<RelatedTaskPreview> createState() => _State();
}

class _State extends TaskViewState<RelatedTaskPreview> {
  Widget _dialog() {
    final t = tc.task;
    return MTDialog(
      key: widget.key,
      topBar: MTTopBar(middle: topBarTitle(t)),
      body: ListView(
        children: [
          TaskHeader(tc),
          if (t.hasDescription) TaskDescriptionField(tc, padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P2)),
          MTAdaptive(child: TaskDetails(tc)),
        ],
      ),
      bottomBar: MTBottomBar(
        innerHeight: 100,
        middle: Column(children: [
          MTListTile(
            leading: const InfoIcon(color: warningColor),
            middle: SmallText(loc.related_task_preview_hint),
            padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(bottom: P2),
            margin: EdgeInsets.zero,
          ),
          MTButton.secondary(
            titleText: loc.action_goto_task_title,
            onTap: () => Navigator.of(context).pop(true),
          ),
        ]),
      ),
      scrollController: scrollController,
      scrollOffsetTop: headerHeight,
      onScrolled: onScrolled,
      // hasKBInput: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => tc.loading ? LoaderScreen(tc, isDialog: true) : _dialog(),
    );
  }
}
