// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as api;

import '../../L1_domain/entities/invoice_detail.dart';

extension InvoiceDetailMapper on api.InvoiceDetailGet {
  InvoiceDetail get invoiceDetail => InvoiceDetail(
        id: id,
        code: code,
        startDate: startDate.toLocal(),
        endDate: endDate?.toLocal(),
        serviceAmount: serviceAmount,
        promoActionCode: promoActionCode,
        finalPrice: finalPrice,
      );
}
