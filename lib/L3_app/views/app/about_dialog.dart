// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/utils/dates.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/divider.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../usecases/communications.dart';
import 'app_title.dart';
import 'app_version.dart';

Future showAboutServiceDialog() async => await showMTDialog(const _AboutDialog(), maxWidth: SCR_XS_WIDTH);

class _AboutDialog extends StatelessWidget {
  const _AboutDialog();

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: const MTAppBar(showCloseButton: true, middle: AppTitle(), color: b2Color),
      body: ListView(
        shrinkWrap: true,
        children: [
          /// версия
          const AppVersion(),

          /// юр. документы
          MTListGroupTitle(titleText: loc.app_legal_docs_title),
          MTListTile(
            leading: const DocumentIcon(),
            titleText: loc.app_legal_rules_title,
            trailing: const ChevronIcon(),
            dividerIndent: P11,
            onTap: go2LegalRules,
          ),
          MTListTile(
            leading: const PrivacyIcon(),
            titleText: loc.app_legal_privacy_policy_title,
            trailing: const ChevronIcon(),
            bottomDivider: false,
            onTap: go2LegalConfidential,
          ),

          /// о приложении
          MTListGroupTitle(titleText: loc.app_about_title),
          MTListTile(
            leading: const ReleaseNotesIcon(),
            titleText: loc.app_release_notes_title,
            trailing: const ChevronIcon(),
            dividerIndent: P11,
            onTap: go2ReleaseNotes,
          ),
          MTListTile(
            leading: const FeedbackIcon(),
            titleText: loc.app_feedback_action_title,
            trailing: const ChevronIcon(),
            bottomDivider: false,
            onTap: go2Feedback,
          ),

          /// контакты
          const SizedBox(height: P6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MTButton.icon(MTImage(ImageName.telegram_icon.name, width: P8, height: P8), onTap: go2Telegram),
              const SizedBox(width: P3),
              MTButton.icon(MTImage(ImageName.mail_icon.name, width: P8, height: P8), onTap: mailUs),
              const SizedBox(width: P3),
              MTButton.icon(MTImage(ImageName.vk_icon.name, width: P8, height: P8), onTap: go2VK),
              const SizedBox(width: P3),
              MTButton.icon(MTImage(ImageName.web_icon.name, width: P8, height: P8), onTap: go2Homepage),
            ],
          ),
          const SizedBox(height: P),

          /// копирайт
          const MTDivider(indent: P3, endIndent: P3, verticalIndent: P3),
          DSmallText('© ${now.date.year} Moroz Team', color: f3Color, align: TextAlign.center),
          const SizedBox(height: P_2),
          DSmallText('© ${now.date.year} ${loc.app_title}', color: f3Color, align: TextAlign.center),
          if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
        ],
      ),
    );
  }
}
