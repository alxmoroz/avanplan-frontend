import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/abs_contact.dart';
import '../../components/colors_base.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/clipboard.dart';

class PersonContactNoTypeDetailsDialog extends StatelessWidget {
  const PersonContactNoTypeDetailsDialog(this._contact, {super.key});
  final AbstractContact _contact;

  Future _tap(BuildContext context) async {
    Navigator.of(context).pop();
    await copyToClipboard(context, _contact.value);
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: const MTAppBar(showCloseButton: true, color: b2Color),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MTListTile(
            middle: H3(_contact.value, maxLines: 2),
            trailing: const CopyIcon(),
            bottomDivider: false,
            onTap: () => _tap(context),
          ),
        ],
      ),
    );
  }
}
