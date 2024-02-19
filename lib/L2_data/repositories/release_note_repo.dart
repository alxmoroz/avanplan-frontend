// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/release_note.dart';
import '../../L1_domain/repositories/abs_release_note_repo.dart';
import '../mappers/release_note.dart';
import '../services/api.dart';

class ReleaseNoteRepo extends AbstractReleaseNoteRepo {
  o_api.ReleaseNotesApi get api => openAPI.getReleaseNotesApi();

  @override
  Future<Iterable<ReleaseNote>> getReleaseNotes(String oldVersion) async {
    final response = await api.releaseNotes(bodyReleaseNotes: (o_api.BodyReleaseNotesBuilder()..oldVersion = oldVersion).build());
    return response.data?.map((rn) => rn.releaseNote) ?? [];
  }
}
