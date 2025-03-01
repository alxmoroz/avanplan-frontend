// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;

import '../../L1_domain/entities/release_note.dart';
import '../../L1_domain/repositories/abs_release_notes_repo.dart';
import '../mappers/release_note.dart';
import '../services/api.dart';

class ReleaseNotesRepo extends AbstractReleaseNotesRepo {
  o_api.ReleaseNotesApi get api => avanplanApi.getReleaseNotesApi();

  @override
  Future<Iterable<ReleaseNote>> getReleaseNotes(String oldVersion) async {
    final response = await api.releaseNotes(oldVersion: oldVersion);
    return response.data?.map((rn) => rn.releaseNote) ?? [];
  }
}
