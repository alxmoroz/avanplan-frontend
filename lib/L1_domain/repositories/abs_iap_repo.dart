// Copyright (c) 2024. Alexandr Moroz

import '../entities/iap_product.dart';

abstract class AbstractIAPRepo {
  Future<Iterable<IAPProduct>> products({required bool appStore, required Function(String error) onError});
  Future pay({
    required IAPProduct product,
    required int wsId,
    required int userId,
    required bool appStore,
    required Function({String? error, num? purchasedAmount}) done,
  });
}
