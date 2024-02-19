// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/release_note.dart';
import '../../extra/services.dart';

part 'release_note_controller.g.dart';

class ReleaseNoteController extends _ReleaseNoteControllerBase with _$ReleaseNoteController {}

abstract class _ReleaseNoteControllerBase with Store {
  @observable
  Iterable<ReleaseNote> _releaseNotes = [];

  @action
  Future getData() async => _releaseNotes = await releaseNoteUC.getReleaseNotes(localSettingsController.oldVersion);

  @computed
  List<ReleaseNote> get releaseNotes => _releaseNotes.sorted((rn1, rn2) => compareNatural(rn2.version, rn1.version));

  @action
  void clearData() => _releaseNotes = [];
}
