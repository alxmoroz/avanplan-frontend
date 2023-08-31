// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/constants.dart';
import '../../components/images.dart';
import '../../components/text.dart';
import '../../extra/services.dart';

class NoSources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: P),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: P),
          MTImage(ImageNames.empty_sources.toString()),
          const SizedBox(height: P),
          H3(loc.source_list_empty_title, align: TextAlign.center),
          const SizedBox(height: P),
          BaseText(loc.source_list_empty_hint, align: TextAlign.center),
          const SizedBox(height: P),
        ],
      ),
    );
  }
}
