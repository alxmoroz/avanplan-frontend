//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:avanplan_api/src/model/task_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tasks_changes.g.dart';

/// TasksChanges
///
/// Properties:
/// * [updatedTask]
/// * [affectedTasks]
@BuiltValue()
abstract class TasksChanges implements Built<TasksChanges, TasksChangesBuilder> {
  @BuiltValueField(wireName: r'updated_task')
  TaskGet get updatedTask;

  @BuiltValueField(wireName: r'affected_tasks')
  BuiltList<TaskGet> get affectedTasks;

  TasksChanges._();

  factory TasksChanges([void updates(TasksChangesBuilder b)]) = _$TasksChanges;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TasksChangesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TasksChanges> get serializer => _$TasksChangesSerializer();
}

class _$TasksChangesSerializer implements PrimitiveSerializer<TasksChanges> {
  @override
  final Iterable<Type> types = const [TasksChanges, _$TasksChanges];

  @override
  final String wireName = r'TasksChanges';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TasksChanges object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'updated_task';
    yield serializers.serialize(
      object.updatedTask,
      specifiedType: const FullType(TaskGet),
    );
    yield r'affected_tasks';
    yield serializers.serialize(
      object.affectedTasks,
      specifiedType: const FullType(BuiltList, [FullType(TaskGet)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TasksChanges object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TasksChangesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'updated_task':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TaskGet),
          ) as TaskGet;
          result.updatedTask.replace(valueDes);
          break;
        case r'affected_tasks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TaskGet)]),
          ) as BuiltList<TaskGet>;
          result.affectedTasks.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TasksChanges deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TasksChangesBuilder();
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
