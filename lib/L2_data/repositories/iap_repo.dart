// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:avanplan_api/avanplan_api.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../L1_domain/entities/iap_product.dart';
import '../../L1_domain/repositories/abs_iap_repo.dart';
import '../services/api.dart';

class IAPRepo extends AbstractIAPRepo {
  @override
  Future<Iterable<IAPProduct>> products({required bool appStore, required Function(String error) onError}) async {
    Iterable<IAPProduct> products = [];

    if (appStore) {
      if (await InAppPurchase.instance.isAvailable()) {
        final response = await InAppPurchase.instance.queryProductDetails(IAPProduct.productsValues.keys.toSet());
        if (response.error != null) {
          await onError(response.error!.message);
        } else {
          products = response.productDetails.map((p) => IAPProduct(
                id: p.id,
                title: p.title,
                description: p.description,
                price: p.price,
                rawPrice: p.rawPrice,
                currencyCode: p.currencyCode,
              ));
        }
      }
    } else {
      products = IAPProduct.productsValues.keys.map((id) => IAPProduct(
            id: id,
            title: '',
            description: '',
            price: '',
            rawPrice: 0,
            currencyCode: '',
          ));
    }

    return products;
  }

  late StreamSubscription<List<PurchaseDetails>> _subscriptionStream;

  @override
  Future pay({
    required IAPProduct product,
    required int wsId,
    required int userId,
    required bool appStore,
    required Function({String? error, num? purchasedAmount}) done,
  }) async {
    if (appStore) {
      await _appStorePay(wsId: wsId, product: product, done: done);
    } else {
      await _ymPay(product.value, wsId, userId);
      await done();
    }
  }

  Future<num?> _deliver(int wsId, PurchaseDetails purchase) async {
    // TODO: IMPORTANT!! Always verify a purchase before delivering the product.
    // print('localVerificationData: ${purchase.verificationData.localVerificationData}');
    // print('serverVerificationData: ${purchase.verificationData.serverVerificationData}');
    // print('source: ${purchase.verificationData.source}');

    // print('delivering ... ${purchase.productID} - ${purchase.purchaseID}');
    final body = (BodyIapNotificationV1PaymentsIapNotificationPostBuilder()
          ..amount = IAPProduct.productsValues[purchase.productID]
          ..operationId = purchase.purchaseID)
        .build();

    return (await avanplanApi.getPaymentsApi().iapNotificationV1PaymentsIapNotificationPost(
              wsId: wsId,
              bodyIapNotificationV1PaymentsIapNotificationPost: body,
            ))
        .data;
  }

  Future _appStorePay({
    required int wsId,
    required IAPProduct product,
    required Function({String? error, num? purchasedAmount}) done,
  }) async {
    final iap = InAppPurchase.instance;
    _subscriptionStream = iap.purchaseStream.listen((purchases) async {
      //TODO: использовать MTError, чтобы отправлять более вменяемые тексты на интерфейс юзеру
      String error = '';
      num purchasedAmount = 0;
      for (final purchase in purchases) {
        if (purchase.status == PurchaseStatus.purchased) {
          purchasedAmount += await _deliver(wsId, purchase) ?? 0;
        } else if (purchase.status == PurchaseStatus.error) {
          error += '${purchase.error?.details}';
        }

        if (purchase.pendingCompletePurchase) {
          await iap.completePurchase(purchase);
        }

        // завершаем обработку транзакции
        if (purchase.status != PurchaseStatus.pending && purchase.productID == product.id) {
          _subscriptionStream.cancel();
          await done(error: error, purchasedAmount: purchasedAmount);
          return;
        }
      }
    });

    await InAppPurchase.instance.buyConsumable(
      purchaseParam: PurchaseParam(
        productDetails: ProductDetails(
          id: product.id,
          title: product.title,
          description: product.description,
          price: product.price,
          rawPrice: product.rawPrice,
          currencyCode: '',
        ),
      ),
    );
  }

  static const _ymHostPath = 'https://yoomoney.ru/quickpay/confirm.xml';
  static const _ymRecipient = '41001777210985';

  Future<bool> _ymPay(int amount, int wsId, int userId) async =>
      await launchUrlString(Uri.encodeFull('$_ymHostPath?receiver=$_ymRecipient&quickpay-form=button&sum=$amount&label=$wsId:$userId'));
}
