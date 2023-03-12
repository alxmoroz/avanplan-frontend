// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'icons.dart';

abstract class _StateIcon extends MTIcon {
  const _StateIcon({super.color, super.size, super.solid});
  bool get _solid => solid ?? (size == null || size! < 60);
}

class RiskIcon extends _StateIcon {
  const RiskIcon({super.color, super.size, super.solid});

  @override
  Widget build(BuildContext context) => Icon(
        _solid ? CupertinoIcons.tortoise_fill : CupertinoIcons.tortoise,
        color: (color ?? warningColor).resolve(context),
        size: size,
      );
}

class OkIcon extends _StateIcon {
  const OkIcon({super.color, super.size, super.solid});
  @override
  Widget build(BuildContext context) => Icon(
        _solid ? CupertinoIcons.rocket_fill : CupertinoIcons.rocket,
        color: (color ?? greenColor).resolve(context),
        size: size,
      );
}

class NoInfoIcon extends _StateIcon {
  const NoInfoIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.question_circle,
        color: (color ?? lightGreyColor).resolve(context),
        size: size,
      );
}

class PauseIcon extends _StateIcon {
  const PauseIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.pause_circle,
        color: (color ?? lightGreyColor).resolve(context),
        size: size,
      );
}

class PlayIcon extends _StateIcon {
  const PlayIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.play_circle,
        color: (color ?? lightGreyColor).resolve(context),
        size: size,
      );
}

class BacklogIcon extends _StateIcon {
  const BacklogIcon({super.color, super.size});
  @override
  Widget build(BuildContext context) => Icon(
        CupertinoIcons.archivebox,
        color: (color ?? lightGreyColor).resolve(context),
        size: size,
      );
}
