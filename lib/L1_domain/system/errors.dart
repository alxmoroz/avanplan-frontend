// Copyright (c) 2022. Alexandr Moroz

class MTError {
  MTError({this.code, this.detail});
  final String? code;
  final String? detail;
}

class MTOAuthError extends MTError {
  MTOAuthError({super.code, super.detail});
}

class MTImportError extends MTError {
  MTImportError({super.code, super.detail});
}
