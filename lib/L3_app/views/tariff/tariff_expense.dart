// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/invoice_detail.dart';
import '../../../L1_domain/entities/tariff_option.dart';
import '../../components/adaptive.dart';
import '../../components/colors_base.dart';
import '../../components/list_tile.dart';
import '../../components/price.dart';
import '../../components/text.dart';
import '../../presenters/bytes.dart';
import '../../presenters/number.dart';

class TariffExpenseTile extends StatelessWidget {
  const TariffExpenseTile(this._to, this._d, {required this.isMyTariff, super.key});
  final InvoiceDetail _d;
  final TariffOption _to;
  final bool isMyTariff;

  num get _price => ((isMyTariff ? _d.finalPrice : null) ?? _to.finalPrice);
  num get _overdraft => _d.serviceAmount - _to.freeLimit;
  num get _expense => _overdraft * _price;

  @override
  Widget build(BuildContext context) {
    String overdraftQuantityStr = '1';

    // опции с превышением
    if (!_to.userManageable) {
      // TODO: deprecated FS_VOLUME, как только не останется старых тарифов
      if ([TOCode.FILE_STORAGE, 'FS_VOLUME'].contains(_to.code)) {
        overdraftQuantityStr = '+${_to.tariffQuantity.humanBytesStr}';
      } else {
        overdraftQuantityStr = '+${_to.tariffQuantity.humanValueStr}';
      }
    }

    return MTListTile(
      titleText: _to.title,
      subtitle: Row(
        children: [
          DSmallText('$overdraftQuantityStr x ', color: f2Color, align: TextAlign.left),
          MTPrice(_price, color: f2Color, size: AdaptiveSize.xs),
        ],
      ),
      trailing: MTPrice(_expense, size: AdaptiveSize.s),
      bottomDivider: false,
    );
  }
}
