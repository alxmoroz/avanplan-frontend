// Copyright (c) 2022. Alexandr Moroz

abstract class BaseSchema {}

abstract class BaseUpsert extends BaseSchema {
  BaseUpsert({required this.id});

  final int? id;
}

abstract class TitleableUpsert extends BaseUpsert {
  TitleableUpsert({
    required int? id,
    required this.title,
  }) : super(id: id);

  final String title;
}

abstract class OrderableUpsert extends TitleableUpsert {
  OrderableUpsert({
    required int? id,
    required String title,
    required this.order,
  }) : super(id: id, title: title);

  final int order;
}

abstract class StatusableUpsert extends TitleableUpsert {
  StatusableUpsert({
    required int? id,
    required String title,
    required this.closed,
  }) : super(id: id, title: title);

  final bool closed;
}
