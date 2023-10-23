// Copyright (c) 2023. Alexandr Moroz

import '../../../L1_domain/entities/source_type.dart';
import '../../components/constants.dart';
import '../../components/select_dialog.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';

Future<SourceType?> selectSourceType({int? selectedId}) async => await showMTSelectDialog(
      refsController.sourceTypes,
      selectedId,
      loc.source_type_selector_title,
      leadingBuilder: (_, st) => st.icon(size: P5),
      subtitleBuilder: (_, st) => st.description.isNotEmpty ? SmallText(st.description) : null,
    );
