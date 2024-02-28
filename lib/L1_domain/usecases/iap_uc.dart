// Copyright (c) 2024. Alexandr Moroz

import '../entities/iap_product.dart';
import '../repositories/abs_iap_repo.dart';

class InAppPurchaseUC {
  InAppPurchaseUC(this.repo);

  final AbstractIAPRepo repo;

  Future<Iterable<IAPProduct>> products({
    required bool appStore,
    required Function(String error) onError,
  }) async =>
      await repo.products(appStore: appStore, onError: onError);

  Future pay({
    required int wsId,
    required int userId,
    required IAPProduct product,
    required bool appStore,
    required Function({String? error, num? purchasedAmount}) done,
  }) async =>
      await repo.pay(
        wsId: wsId,
        userId: userId,
        product: product,
        appStore: appStore,
        done: done,
      );
}
