import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text.dart';
import 'constants.dart';
import 'divider.dart';
import 'gesture.dart';
import 'loader.dart';
import 'material_wrapper.dart';

class MTListTile extends StatelessWidget with GestureManaging {
  const MTListTile({
    super.key,
    this.leading,
    this.middle,
    this.subtitle,
    this.titleText = '',
    this.trailing,
    this.onTap,
    this.onHover,
    this.color = Colors.transparent,
    this.padding,
    this.verticalPadding = P2,
    this.margin,
    this.topMargin = 0,
    this.dividerIndent,
    this.dividerEndIndent,
    this.topDivider = false,
    this.bottomDivider = false,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.uf = true,
    this.loading,
    this.minHeight = DEF_TAPPABLE_ICON_SIZE,
    this.titleTextColor,
    this.splashColor = mainColor,
    this.titleTextMaxLines,
    this.titleTextAlign,
    this.decoration,
    this.leadingSpacing,
  });
  final Widget? leading;
  final Widget? middle;
  final Widget? subtitle;
  final String titleText;
  final Widget? trailing;
  final Function()? onTap;
  final Function(bool)? onHover;

  final Color color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double topMargin;
  final double verticalPadding;
  final double? dividerIndent;
  final double? dividerEndIndent;
  final bool topDivider;
  final bool bottomDivider;
  final CrossAxisAlignment crossAxisAlignment;
  final bool uf;
  final bool? loading;
  final double? minHeight;
  final Color splashColor;
  final Color? titleTextColor;
  final int? titleTextMaxLines;
  final TextAlign? titleTextAlign;
  final BoxDecoration? decoration;
  final double? leadingSpacing;

  Widget get _divider => MTDivider(
        indent: dividerIndent ?? padding?.left ?? DEF_HP,
        endIndent: dividerEndIndent ?? padding?.right ?? DEF_HP,
      );

  EdgeInsets get _defaultPadding => EdgeInsets.symmetric(horizontal: DEF_HP, vertical: verticalPadding);

  @override
  Widget build(BuildContext context) {
    final hoverColor = mainColor.resolve(context).withAlpha(7);

    final hasMiddle = middle != null || titleText.isNotEmpty;
    final hasSubtitle = subtitle != null;
    final bgColor = color.resolve(context);
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      children: [
        Container(
          margin: margin ?? EdgeInsets.only(top: topMargin),
          decoration: decoration ?? BoxDecoration(color: bgColor),
          child: material(
            InkWell(
              onTap: onTap != null ? () => tapAction(uf, onTap!) : null,
              onHover: onHover,
              hoverColor: hoverColor,
              highlightColor: hoverColor,
              splashColor: splashColor.resolve(context).withAlpha(15),
              canRequestFocus: false,
              focusColor: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (topDivider) _divider,
                  Padding(
                    padding: padding ?? _defaultPadding,
                    child: Row(
                      crossAxisAlignment: crossAxisAlignment,
                      children: [
                        SizedBox(height: minHeight),
                        if (leading != null) ...[
                          leading!,
                          if (hasMiddle || hasSubtitle) SizedBox(width: leadingSpacing ?? P2),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (hasMiddle) middle ?? BaseText(titleText, color: titleTextColor, maxLines: titleTextMaxLines, align: titleTextAlign),
                              if (hasSubtitle) ...[
                                if (hasMiddle) const SizedBox(height: P),
                                subtitle!,
                              ],
                            ],
                          ),
                        ),
                        if (trailing != null) trailing!,
                      ],
                    ),
                  ),
                  if (bottomDivider) _divider,
                ],
              ),
            ),
          ),
        ),
        if (loading == true) const MTLoader(),
      ],
    );
  }
}

class MTSectionTitle extends MTListTile {
  const MTSectionTitle(
    String text, {
    super.key,
    super.leading,
    super.trailing,
    super.verticalPadding = DEF_VP / 2,
    super.topMargin = DEF_VP / 2,
    super.titleTextColor = f2Color,
    super.titleTextAlign,
    super.titleTextMaxLines,
    super.leadingSpacing = P,
    super.minHeight = 0,
    super.onTap,
  }) : super(titleText: text);
}

class MTListText extends MTListTile {
  const MTListText(
    String text, {
    super.key,
    super.leading,
    super.trailing,
    super.verticalPadding = 0,
    super.topMargin = DEF_VP / 2,
    super.titleTextColor,
    super.titleTextAlign,
    super.titleTextMaxLines,
    super.leadingSpacing = P,
    super.minHeight = 0,
    super.onTap,
  }) : super(titleText: text);

  MTListText.medium(
    String text, {
    super.key,
    super.leading,
    super.trailing,
    super.verticalPadding = 0,
    super.topMargin = DEF_VP / 2,
    super.titleTextColor,
    super.titleTextAlign,
    super.titleTextMaxLines,
    super.leadingSpacing = P,
    super.minHeight = 0,
    super.onTap,
  }) : super(middle: BaseText.medium(text, maxLines: titleTextMaxLines, align: titleTextAlign, color: titleTextColor));

  MTListText.h2(
    String text, {
    super.key,
    super.leading,
    super.trailing,
    super.topMargin = DEF_VP,
    super.verticalPadding = 0,
    super.titleTextColor,
    super.titleTextAlign,
    super.titleTextMaxLines,
    super.leadingSpacing = P,
    super.minHeight = 0,
    super.onTap,
  }) : super(middle: H2(text, maxLines: titleTextMaxLines, align: titleTextAlign, color: titleTextColor));

  MTListText.h3(
    String text, {
    super.key,
    super.leading,
    super.trailing,
    super.topMargin = DEF_VP,
    super.verticalPadding = 0,
    super.titleTextColor,
    super.titleTextAlign,
    super.titleTextMaxLines,
    super.leadingSpacing = P,
    super.minHeight = 0,
    super.onTap,
  }) : super(middle: H3(text, maxLines: titleTextMaxLines, align: titleTextAlign, color: titleTextColor));

  MTListText.small(
    String text, {
    super.key,
    super.leading,
    super.trailing,
    super.topMargin = DEF_VP / 2,
    super.verticalPadding = 0,
    super.titleTextColor = f2Color,
    super.titleTextAlign,
    super.titleTextMaxLines,
    super.leadingSpacing = P,
    super.minHeight = 0,
    super.onTap,
  }) : super(middle: SmallText(text, maxLines: titleTextMaxLines, align: titleTextAlign, color: titleTextColor));
}
