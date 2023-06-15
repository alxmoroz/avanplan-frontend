// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/base_entity.dart';
import 'colors.dart';
import 'constants.dart';
import 'mt_circle.dart';
import 'mt_dialog.dart';
import 'mt_list_tile.dart';
import 'mt_toolbar.dart';
import 'text_widgets.dart';

Future<int?> showMTSelectDialog<T extends RPersistable>(
  List<T> items,
  int? selectedId,
  String? titleText, {
  Widget Function(BuildContext, T)? valueBuilder,
}) async =>
    await showMTDialog<int?>(
      _MTSelectDialog<T>(
        items,
        selectedId,
        titleText,
        valueBuilder,
      ),
    );

class _MTSelectDialog<T extends RPersistable> extends StatelessWidget {
  const _MTSelectDialog(this.items, this.selectedId, this.titleText, this.valueBuilder);
  final List<T> items;
  final int? selectedId;
  final String? titleText;
  final Widget Function(BuildContext, T)? valueBuilder;

  int get selectedIndex => items.indexWhere((i) => i.id == selectedId);
  int get itemCount => items.length;

  Widget itemBuilder(BuildContext context, int index) {
    final item = items[index];
    return MTListTile(
      middle: valueBuilder != null ? valueBuilder!(context, item) : NormalText('$item'),
      trailing: selectedIndex == index ? const MTCircle(size: P, color: mainColor) : null,
      bottomDivider: index < itemCount - 1,
      onTap: () => Navigator.of(context).pop(item.id),
    );
  }

  @override
  Widget build(BuildContext context) => MTDialog(
        topBar: MTTopBar(titleText: titleText),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        ),
      );
}
