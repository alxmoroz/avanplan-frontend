// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'colors.dart';
import 'text.dart';

class MTLinkify extends StatelessWidget {
  const MTLinkify(this.text, {this.maxLines, super.key, this.style, this.linkStyle, this.onTap});
  final String text;
  final int? maxLines;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ?? BaseText('', maxLines: maxLines).style(context);
    return SelectableLinkify(
      text: text,
      minLines: 1,
      maxLines: maxLines,
      style: baseStyle,
      linkStyle: linkStyle ?? baseStyle.copyWith(color: mainColor.resolve(context)),
      linkifiers: const [UrlLinkifier(), EmailLinkifier(), PhoneNumberLinkifier()],
      contextMenuBuilder: (_, state) => AdaptiveTextSelectionToolbar.buttonItems(
        anchors: state.contextMenuAnchors,
        buttonItems: state.contextMenuButtonItems,
      ),
      onOpen: (link) async => await launchUrlString(link.url),
      onTap: onTap,
    );
  }
}
