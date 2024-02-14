// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/iap_product.dart';
import '../../components/images.dart';
import '../../extra/services.dart';

part 'iap_controller.g.dart';

class IAPController extends _IAPControllerBase with _$IAPController {}

abstract class _IAPControllerBase with Store {
  @observable
  bool waitingPayment = false;

  @observable
  List<IAPProduct> products = [];

  @action
  Future getProducts() async {
    loader.set(imageName: ImageName.purchase.name, titleText: loc.loader_refreshing_title);
    loader.start();
    products = (await iapUC.products(
      (errorText) => loader.set(
        imageName: ImageName.purchase.name,
        titleText: loc.error_get_products_title,
        descriptionText: errorText,
        actionText: loc.ok,
      ),
    ))
        .sorted((p1, p2) => p1.value.compareTo(p2.value));
    await loader.stop();
  }

  @action
  Future pay(int wsId, IAPProduct product) async {
    final userId = accountController.me?.id;
    if (userId != null) {
      loader.set(imageName: ImageName.purchase.name, titleText: loc.loader_purchasing_title);
      loader.start();
      await iapUC.pay(
        product: product,
        wsId: wsId,
        userId: userId,
        done: ({String? error, num? purchasedAmount}) {
          if (error != null && error.isNotEmpty) {
            loader.set(
              imageName: ImageName.purchase.name,
              titleText: loc.error_purchase_title,
              descriptionText: error,
              actionText: loc.ok,
            );
          } else {
            waitingPayment = purchasedAmount == null;
            if (purchasedAmount != null) {
              wsMainController.ws(wsId).balance += purchasedAmount;
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
