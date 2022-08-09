//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/body_update_my_account_v1_my_account_put.dart';
import 'package:openapi/src/model/http_validation_error.dart';
import 'package:openapi/src/model/msg.dart';
import 'package:openapi/src/model/person.dart';
import 'package:openapi/src/model/person_get.dart';
import 'package:openapi/src/model/priority.dart';
import 'package:openapi/src/model/priority_get.dart';
import 'package:openapi/src/model/source_get.dart';
import 'package:openapi/src/model/source_type_get.dart';
import 'package:openapi/src/model/source_upsert.dart';
import 'package:openapi/src/model/status.dart';
import 'package:openapi/src/model/status_get.dart';
import 'package:openapi/src/model/task.dart';
import 'package:openapi/src/model/task_get.dart';
import 'package:openapi/src/model/task_source.dart';
import 'package:openapi/src/model/task_source_get.dart';
import 'package:openapi/src/model/task_source_upsert.dart';
import 'package:openapi/src/model/task_upsert.dart';
import 'package:openapi/src/model/token.dart';
import 'package:openapi/src/model/user_get.dart';
import 'package:openapi/src/model/validation_error.dart';
import 'package:openapi/src/model/workspace_get.dart';

part 'serializers.g.dart';

@SerializersFor([
  BodyUpdateMyAccountV1MyAccountPut,
  HTTPValidationError,
  Msg,
  Person,
  PersonGet,
  Priority,
  PriorityGet,
  SourceGet,
  SourceTypeGet,
  SourceUpsert,
  Status,
  StatusGet,
  Task,
  TaskGet,
  TaskSource,
  TaskSourceGet,
  TaskSourceUpsert,
  TaskUpsert,
  Token,
  UserGet,
  ValidationError,
  WorkspaceGet,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TaskSource)]),
        () => ListBuilder<TaskSource>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(WorkspaceGet)]),
        () => ListBuilder<WorkspaceGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Task)]),
        () => ListBuilder<Task>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TaskSourceUpsert)]),
        () => ListBuilder<TaskSourceUpsert>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TaskGet)]),
        () => ListBuilder<TaskGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SourceTypeGet)]),
        () => ListBuilder<SourceTypeGet>(),
      )
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
