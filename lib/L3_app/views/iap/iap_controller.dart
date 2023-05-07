// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/iap_product.dart';
import '../../extra/services.dart';
import '../../presenters/loader_presenter.dart';

part 'iap_controller.g.dart';

class IAPController = _IAPControllerBase with _$IAPController;

abstract class _IAPControllerBase with Store {
  @observable
  bool waitingPayment = false;

  @observable
  List<IAPProduct> products = [];

  @action
  Future fetchProducts() async {
    loader.start();
    loader.set(icon: ldrPurchaseIcon, titleText: loc.loader_refreshing_title);
    products = (await iapUC.products(
      (errorText) => loader.set(
        icon: ldrPurchaseIcon,
        titleText: loc.error_fetch_products_title,
        descriptionText: errorText,
        actionText: loc.ok,
      ),
    ))
        .sorted((p1, p2) => p1.value.compareTo(p2.value));
    await loader.stop();
  }

  @action
  Future pay(int wsId, IAPProduct product) async {
    final userId = accountController.user?.id;
    if (userId != null) {
      loader.start();
      loader.set(icon: ldrPurchaseIcon, titleText: loc.loader_purchasing_title);
      await iapUC.pay(
        product: product,
        wsId: wsId,
        userId: userId,
        done: ({String? error, num? purchasedAmount}) {
          if (error != null && error.isNotEmpty) {
            loader.set(
              icon: ldrPurchaseIcon,
              titleText: loc.error_purchase_title,
              descriptionText: error,
              actionText: loc.ok,
            );
          } else {
            waitingPayment = purchasedAmount == null;
            if (purchasedAmount != null) {
              mainController.wsForId(wsId).balance += purchasedAmount;
            }
            loader.stop();
          }
        },
      );
    }
  }

  @action
  void resetWaiting() => waitingPayment = false;
}
