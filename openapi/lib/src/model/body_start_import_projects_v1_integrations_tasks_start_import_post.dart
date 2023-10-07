//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/task_remote.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_start_import_projects_v1_integrations_tasks_start_import_post.g.dart';

/// BodyStartImportProjectsV1IntegrationsTasksStartImportPost
///
/// Properties:
/// * [projects] 
@BuiltValue()
abstract class BodyStartImportProjectsV1IntegrationsTasksStartImportPost implements Built<BodyStartImportProjectsV1IntegrationsTasksStartImportPost, BodyStartImportProjectsV1IntegrationsTasksStartImportPostBuilder> {
  @BuiltValueField(wireName: r'projects')
  BuiltList<TaskRemote> get projects;

  BodyStartImportProjectsV1IntegrationsTasksStartImportPost._();

  factory BodyStartImportProjectsV1IntegrationsTasksStartImportPost([void updates(BodyStartImportProjectsV1IntegrationsTasksStartImportPostBuilder b)]) = _$BodyStartImportProjectsV1IntegrationsTasksStartImportPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyStartImportProjectsV1IntegrationsTasksStartImportPostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyStartImportProjectsV1IntegrationsTasksStartImportPost> get serializer => _$BodyStartImportProjectsV1IntegrationsTasksStartImportPostSerializer();
}

class _$BodyStartImportProjectsV1IntegrationsTasksStartImportPostSerializer implements PrimitiveSerializer<BodyStartImportProjectsV1IntegrationsTasksStartImportPost> {
  @override
  final Iterable<Type> types = const [BodyStartImportProjectsV1IntegrationsTasksStartImportPost, _$BodyStartImportProjectsV1IntegrationsTasksStartImportPost];

  @override
  final String wireName = r'BodyStartImportProjectsV1IntegrationsTasksStartImportPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyStartImportProjectsV1IntegrationsTasksStartImportPost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'projects';
    yield serializers.serialize(
      object.projects,
      specifiedType: const FullType(BuiltList, [FullType(TaskRemote)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyStartImportProjectsV1IntegrationsTasksStartImportPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyStartImportProjectsV1IntegrationsTasksStartImportPostBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'projects':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TaskRemote)]),
          ) as BuiltList<TaskRemote>;
          result.projects.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyStartImportProjectsV1IntegrationsTasksStartImportPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyStartImportProjectsV1IntegrationsTasksStartImportPostBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

