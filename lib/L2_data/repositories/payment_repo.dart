// Copyright (c) 2022. Alexandr Moroz

import 'package:url_launcher/url_launcher_string.dart';

import '../../L1_domain/repositories/abs_payment_repo.dart';

class PaymentRepo extends AbstractPaymentRepo {
  static const host_path = 'https://yoomoney.ru/quickpay/confirm.xml';
  static const recipient = '41001777210985';

  @override
  Future<bool> ymQuickPayForm(num amount, int wsId, int userId) async {
    final url = Uri.encodeFull('$host_path?receiver=$recipient&quickpay-form=button&sum=$amount&label=$wsId:$userId');
    return await launchUrlString(url);
  }
}
