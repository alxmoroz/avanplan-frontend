// Copyright (c) 2022. Alexandr Moroz

class MTError {
  MTError(this.title, {this.description, this.detail});
  final String title;
  final String? description;
  final String? detail;
}

class MTOAuthError extends MTError {
  MTOAuthError(super.title, {super.description, super.detail});
}
