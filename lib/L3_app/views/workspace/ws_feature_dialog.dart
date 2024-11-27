// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/text.dart';
import '../_base/loader_screen.dart';
import 'ws_controller.dart';

Future wsFeature(WSController wsc, int index) async => await showMTDialog(_WSFeatureDialog(wsc, index));

class _WSFeatureDialog extends StatelessWidget {
  const _WSFeatureDialog(this._wsc, this._index);
  final WSController _wsc;
  final int _index;

  Widget _dialog(BuildContext context) {
    final ws = _wsc.ws;
    final tariff = ws.tariff;
    final f = tariff.features[_index];
    final subscribed = ws.hasExpense(f.code);
    return MTDialog(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: SizedBox()),
          Container(
            decoration: BoxDecoration(color: b3Color.resolve(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                H2(
                  f.title,
                  align: TextAlign.center,
                  padding: EdgeInsets.all(P3),
                ),
                BaseText(f.description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) => _wsc.loading ? LoaderScreen(_wsc, isDialog: true) : _dialog(context));
  }
}
