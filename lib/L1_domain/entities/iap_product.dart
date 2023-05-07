// Copyright (c) 2023. Alexandr Moroz

class IAPProduct {
  IAPProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rawPrice,
    required this.currencyCode,
  });

  final String id;
  final String title;
  final String description;
  final String price;
  final double rawPrice;
  final String currencyCode;

  static const productsValues = {
    'Avanplan_300': 300,
    'Avanplan_500': 500,
    'Avanplan_1000': 1000,
    'Avanplan_5000': 5000,
  };

  int get value => productsValues[id] ?? 0;
}

class IAPurchase {
  IAPurchase({
    required this.purchaseID,
    required this.productID,
  });

  final String purchaseID;
  final String productID;
}
