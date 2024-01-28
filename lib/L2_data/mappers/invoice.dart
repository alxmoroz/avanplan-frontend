// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/invoice.dart';
import '../../L1_domain/entities/invoice_detail.dart';
import 'contract.dart';
import 'tariff.dart';

extension InvoiceDetailMapper on api.InvoiceDetailGet {
  InvoiceDetail get invoiceDetail => InvoiceDetail(
        id: id,
        startDate: startDate.toLocal(),
        endDate: endDate?.toLocal(),
        optionCode: optionCode,
        serviceAmount: serviceAmount,
      );
}

extension InvoiceMapper on api.InvoiceGet {
  Invoice get invoice => Invoice(
        id: id,
        tariff: tariff!.tariff,
        contract: contract.contract,
        details: details.map((d) => d.invoiceDetail),
      );
}
