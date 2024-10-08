// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../extra/router.dart';
import 'colors.dart';
import 'text.dart';

class MTLinkify extends StatelessWidget {
  const MTLinkify(this.text, {this.maxLines, super.key, this.style, this.linkStyle, this.textAlign, this.onTap});
  final String text;
  final int? maxLines;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final TextAlign? textAlign;
  final Function()? onTap;

  Future _openLink(String urlString) async {
    final uri = Uri.parse(urlString);
    if (['avanplan.ru', 'test.avanplan.ru', 'localhost', '127.0.0.1'].contains(uri.host)) {
      await router.goInner(uri);
    } else {
      await launchUrlString(urlString);
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ?? BaseText('', maxLines: maxLines).style(context);
    return SelectableLinkify(
      text: text,
      textAlign: textAlign,
      minLines: 1,
      maxLines: maxLines,
      style: baseStyle,
      linkStyle: linkStyle ?? baseStyle.copyWith(color: mainColor.resolve(context)),
      linkifiers: const [UrlLinkifier(), EmailLinkifier(), PhoneNumberLinkifier()],
      contextMenuBuilder: (_, state) => AdaptiveTextSelectionToolbar.buttonItems(
        anchors: state.contextMenuAnchors,
        buttonItems: state.contextMenuButtonItems,
      ),
      onOpen: (link) async => await _openLink(link.url),
      onTap: onTap,
    );
  }
}
