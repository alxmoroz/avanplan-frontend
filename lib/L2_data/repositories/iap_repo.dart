// Copyright (c) 2022. Alexandr Moroz

import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../L1_domain/entities/iap_product.dart';
import '../../L1_domain/repositories/abs_payment_repo.dart';
import '../services/platform.dart';

class IAPRepo extends AbstractIAPRepo {
  @override
  Future<Iterable<IAPProduct>> products(Function(String error) onError) async {
    Iterable<IAPProduct> products = [];

    if (isIOS) {
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

  late StreamSubscription<List<PurchaseDetails>> _iapSubscriptionStream;

  @override
  Future pay({
    required IAPProduct product,
    required int wsId,
    required int userId,
    required Function(List<String>) done,
  }) async {
    if (isIOS) {
      await _iapPay(wsId: wsId, userId: userId, product: product, done: done);
    } else {
      await _ymQuickPay(product.value, wsId, userId);
      await done([]);
    }
  }

  Future _iapPay({
    required int wsId,
    required int userId,
    required IAPProduct product,
    required Function(List<String>) done,
  }) async {
    bool _verify(PurchaseDetails pd) {
      // TODO: IMPORTANT!! Always verify a purchase before delivering the product.
      return product.id == pd.productID;
    }

    Future _deliver(String? purchaseId) async {
      print(purchaseId);
      print(product.value);
      print(wsId);
      print('backend payment_notification');
    }

    final iap = InAppPurchase.instance;
    _iapSubscriptionStream = iap.purchaseStream.listen((pds) async {
      //TODO: можно использовать список MTErrors
      final List<String> errors = [];
      for (final pd in pds) {
        String error = '';
        if (pd.status == PurchaseStatus.pending) {
          return;
        } else if (pd.status == PurchaseStatus.error) {
          error = '${pd.error?.details}';
        } else if (pd.status == PurchaseStatus.purchased) {
          if (_verify(pd)) {
            await _deliver(pd.purchaseID);
          } else {
            error = 'Not verified: ${pd.productID}';
          }
        }
        if (error.isEmpty) {
          if (pd.pendingCompletePurchase) {
            await iap.completePurchase(pd);
          }
        } else {
          errors.add(error);
        }
      }
      await done(errors);
      _iapSubscriptionStream.cancel();
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

  Future<bool> _ymQuickPay(int amount, int wsId, int userId) async {
    const _ym_host_path = 'https://yoomoney.ru/quickpay/confirm.xml';
    const _ymRecipient = '41001777210985';
    final url = Uri.encodeFull('$_ym_host_path?receiver=$_ymRecipient&quickpay-form=button&sum=$amount&label=$wsId:$userId');
    return await launchUrlString(url);
  }
}
