// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/invoice_detail.dart';
import '../../../L1_domain/entities/tariff_option.dart';
import '../../components/adaptive.dart';
import '../../components/colors.dart';
import '../../components/list_tile.dart';
import '../../components/price.dart';
import '../../components/text.dart';
import '../../presenters/bytes.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff_option.dart';

class TariffExpenseTile extends StatelessWidget {
  const TariffExpenseTile(this._to, this._d, {this.bottomDivider = true, super.key});
  final InvoiceDetail _d;
  final TariffOption _to;
  final bool bottomDivider;

  num get _price => _d.finalPrice ?? _to.finalPrice;
  num get _overdraft => ((_d.serviceAmount - _to.freeLimit) / _to.tariffQuantity).ceil();
  num get _expense => _overdraft * _price;

  @override
  Widget build(BuildContext context) {
    String overdraftQuantityStr = '1';

    // опции с превышением
    if (!_to.userManageable) {
      if ([
        TOCode.FILE_STORAGE,
        // TODO: deprecated FS_VOLUME, как только не останется старых тарифов
        'FS_VOLUME',
      ].contains(_to.code)) {
        overdraftQuantityStr = '+${_overdraft.humanBytesStr}';
      } else {
        overdraftQuantityStr = '+${_overdraft.humanValueStr}';
      }
    }

    return MTListTile(
      titleText: _to.title,
      subtitle: Row(
        children: [
          if (_price > 0) DSmallText('$overdraftQuantityStr x ', color: f2Color, align: TextAlign.left),
          MTPrice(_price, color: f2Color, size: AdaptiveSize.xs),
          if (_d.endDate != null) DSmallText(' ${_to.priceTerm(_d.endDate)}', color: f2Color, align: TextAlign.left),
        ],
      ),
      trailing: DText('${_expense.currency} $CURRENCY_SYMBOL_ROUBLE'),
      bottomDivider: bottomDivider,
    );
  }
}
