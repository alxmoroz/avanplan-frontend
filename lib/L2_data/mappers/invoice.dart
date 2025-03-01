// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as api;

import '../../L1_domain/entities/invoice.dart';
import 'contract.dart';
import 'invoice_detail.dart';
import 'tariff.dart';

extension InvoiceMapper on api.InvoiceGet {
  Invoice get invoice => Invoice(
        id: id,
        tariff: tariff!.tariff,
        contract: contract.contract,
        details: details.map((d) => d.invoiceDetail),
      );
}
