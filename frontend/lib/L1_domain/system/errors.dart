// Copyright (c) 2022. Alexandr Moroz

class MTException {
  MTException({
    required this.code,
    this.detail,
  });
  final String code;
  final String? detail;
}
