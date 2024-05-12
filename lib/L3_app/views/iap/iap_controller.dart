// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/iap_product.dart';
import '../../components/images.dart';
import '../../extra/services.dart';
import '../../views/_base/loadable.dart';

part 'iap_controller.g.dart';

class IAPController extends _IAPControllerBase with _$IAPController {
  IAPController() {
    stopLoading();
  }
}

abstract class _IAPControllerBase with Store, Loadable {
  @observable
  List<IAPProduct> products = [];

  @observable
  bool? _isAppStore;
  @computed
  bool get paymentMethodSelected => _isAppStore != null;

  @override
  startLoading() {
    setLoaderScreen(imageName: ImageName.purchase.name, titleText: loc.loader_purchasing_title);
    super.startLoading();
  }

  @action
  Future getProducts({required bool isAppStore}) async {
    startLoading();
    _isAppStore = isAppStore;

    products = (await iapUC.products(
      appStore: isAppStore,
      onError: (errorText) => setLoaderScreen(
        imageName: ImageName.purchase.name,
        titleText: loc.error_get_products_title,
        descriptionText: errorText,
        actionText: loc.ok,
      ),
    ))
        .sorted((p1, p2) => p1.value.compareTo(p2.value));

    stopLoading();
  }

  Future getAppStoreProducts() async => await getProducts(isAppStore: true);
  Future getYMProducts() async => await getProducts(isAppStore: false);

  @action
  Future pay(int wsId, IAPProduct product) async {
    final userId = accountController.me?.id;
    if (userId != null) {
      startLoading();
      await iapUC.pay(
        product: product,
        wsId: wsId,
        userId: userId,
        appStore: _isAppStore == true,
        done: ({String? error, num? purchasedAmount}) {
          if (error != null && error.isNotEmpty) {
            setLoaderScreen(
              imageName: ImageName.purchase.name,
              titleText: loc.error_purchase_title,
              descriptionText: error,
              actionText: loc.ok,
            );
          } else {
            if (purchasedAmount != null) {
              wsMainController.ws(wsId).balance += purchasedAmount;
            }
            stopLoading();
          }
        },
      );
    }
  }

  @action
  void reset() {
    _isAppStore = null;
    products = [];
    stopLoading();
  }
}
