// Copyright (c) 2023. Alexandr Moroz

import '../../../L1_domain/entities/remote_source_type.dart';
import '../../components/constants.dart';
import '../../components/select_dialog.dart';
import '../../components/text.dart';
import '../../presenters/remote_source.dart';
import '../app/services.dart';

Future<RemoteSourceType?> selectSourceType({int? selectedId}) async => await showMTSelectDialog(
      refsController.sourceTypes,
      selectedId,
      loc.source_type_selector_title,
      dividerIndent: P5 + DEF_TAPPABLE_ICON_SIZE,
      leadingBuilder: (_, st) => st.icon(size: DEF_TAPPABLE_ICON_SIZE),
      subtitleBuilder: (_, st) => st.description.isNotEmpty ? SmallText(st.description, maxLines: 1) : null,
    );
