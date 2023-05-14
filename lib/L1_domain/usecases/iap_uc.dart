// Copyright (c) 2022. Alexandr Moroz

import '../entities/iap_product.dart';
import '../repositories/abs_payment_repo.dart';

class InAppPurchaseUC {
  InAppPurchaseUC(this.repo);

  final AbstractIAPRepo repo;

  Future<Iterable<IAPProduct>> products(Function(String error) onError) async => await repo.products(onError);
  Future pay({
    required int wsId,
    required int userId,
    required IAPProduct product,
    required Function({String? error, num? purchasedAmount}) done,
  }) async =>
      await repo.pay(
        wsId: wsId,
        userId: userId,
        product: product,
        done: done,
      );
}
