// Copyright (c) 2022. Alexandr Moroz

import '../entities/iap_product.dart';

abstract class AbstractIAPRepo {
  Future<Iterable<IAPProduct>> products(Function(String) onError);
  Future pay({
    required IAPProduct product,
    required int wsId,
    required int userId,
    required Function(List<String>) done,
  });
}
