// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'circular_progress.dart';
import 'colors.dart';
import 'constants.dart';
import 'dialog.dart';
import 'toolbar.dart';

Future<Uri?> showWebViewDialog(Uri uri, {bool Function(String)? onPageStartedExit, Color? bgColor}) async => await showMTDialog<Uri?>(
      _MTWebViewDialog(
        uri,
        onPageStartedExit: onPageStartedExit,
        bgColor: bgColor,
      ),
    );

class _MTWebViewDialog extends StatelessWidget {
  const _MTWebViewDialog(this.uri, {this.onPageStartedExit, this.bgColor});
  final Uri uri;
  final bool Function(String)? onPageStartedExit;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = (this.bgColor ?? b3Color).resolve(context);
    return MTDialog(
      topBar: MTTopBar(color: bgColor),
      bgColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: bgColor, child: const Center(child: MTCircularProgress(size: P10))),
            WebViewWidget(
              gestureRecognizers: const {Factory<VerticalDragGestureRecognizer>(VerticalDragGestureRecognizer.new)},
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(bgColor)
                ..setNavigationDelegate(
                  NavigationDelegate(onPageStarted: (url) {
                    if (onPageStartedExit != null) {
                      if (onPageStartedExit!(url)) {
                        Navigator.of(context).pop(Uri.parse(url));
                      }
                    }
                  }),
                )
                ..loadRequest(uri),
            ),
          ],
        ),
      ),
    );
  }
}
