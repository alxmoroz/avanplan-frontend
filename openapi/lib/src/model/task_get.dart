//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/priority_get.dart';
import 'package:openapi/src/model/task_source_get.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/person_get.dart';
import 'package:openapi/src/model/status_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_get.g.dart';

/// TaskGet
///
/// Properties:
/// * [id] 
/// * [createdOn] 
/// * [updatedOn] 
/// * [workspaceId] 
/// * [title] 
/// * [closed] 
/// * [description] 
/// * [startDate] 
/// * [dueDate] 
/// * [assignee] 
/// * [author] 
/// * [priority] 
/// * [status] 
/// * [taskSource] 
/// * [tasks] 
@BuiltValue()
abstract class TaskGet implements Built<TaskGet, TaskGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'created_on')
  DateTime get createdOn;

  @BuiltValueField(wireName: r'updated_on')
  DateTime get updatedOn;

  @BuiltValueField(wireName: r'workspace_id')
  int get workspaceId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'closed')
  bool? get closed;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'start_date')
  DateTime? get startDate;

  @BuiltValueField(wireName: r'due_date')
  DateTime? get dueDate;

  @BuiltValueField(wireName: r'assignee')
  PersonGet? get assignee;

  @BuiltValueField(wireName: r'author')
  PersonGet? get author;

  @BuiltValueField(wireName: r'priority')
  PriorityGet? get priority;

  @BuiltValueField(wireName: r'status')
  StatusGet? get status;

  @BuiltValueField(wireName: r'task_source')
  TaskSourceGet? get taskSource;

  @BuiltValueField(wireName: r'tasks')
  BuiltList<TaskGet>? get tasks;

  TaskGet._();

  factory TaskGet([void updates(TaskGetBuilder b)]) = _$TaskGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskGetBuilder b) => b
      ..closed = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskGet> get serializer => _$TaskGetSerializer();
}

class _$TaskGetSerializer implements PrimitiveSerializer<TaskGet> {
  @override
  final Iterable<Type> types = const [TaskGet, _$TaskGet];

  @override
  final String wireName = r'TaskGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'created_on';
    yield serializers.serialize(
      object.createdOn,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_on';
    yield serializers.serialize(
      object.updatedOn,
      specifiedType: const FullType(DateTime),
    );
    yield r'workspace_id';
    yield serializers.serialize(
      object.workspaceId,
      specifiedType: const FullType(int),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    if (object.closed != null) {
      yield r'closed';
      yield serializers.serialize(
        object.closed,
        specifiedType: const FullType(bool),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.startDate != null) {
      yield r'start_date';
      yield serializers.serialize(
        object.startDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.dueDate != null) {
      yield r'due_date';
      yield serializers.serialize(
        object.dueDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.assignee != null) {
      yield r'assignee';
      yield serializers.serialize(
        object.assignee,
        specifiedType: const FullType(PersonGet),
      );
    }
    if (object.author != null) {
      yield r'author';
      yield serializers.serialize(
        object.author,
        specifiedType: const FullType(PersonGet),
      );
    }
    if (object.priority != null) {
      yield r'priority';
      yield serializers.serialize(
        object.priority,
        specifiedType: const FullType(PriorityGet),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(StatusGet),
      );
    }
    if (object.taskSource != null) {
      yield r'task_source';
      yield serializers.serialize(
        object.taskSource,
        specifiedType: const FullType(TaskSourceGet),
      );
    }
    if (object.tasks != null) {
      yield r'tasks';
      yield serializers.serialize(
        object.tasks,
        specifiedType: const FullType(BuiltList, [FullType(TaskGet)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskGetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'created_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdOn = valueDes;
          break;
        case r'updated_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedOn = valueDes;
          break;
        case r'workspace_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workspaceId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'closed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.closed = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'start_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startDate = valueDes;
          break;
        case r'due_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.dueDate = valueDes;
          break;
        case r'assignee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PersonGet),
          ) as PersonGet;
          result.assignee.replace(valueDes);
          break;
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PersonGet),
          ) as PersonGet;
          result.author.replace(valueDes);
          break;
        case r'priority':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PriorityGet),
          ) as PriorityGet;
          result.priority.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StatusGet),
          ) as StatusGet;
          result.status.replace(valueDes);
          break;
        case r'task_source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TaskSourceGet),
          ) as TaskSourceGet;
          result.taskSource.replace(valueDes);
          break;
        case r'tasks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TaskGet)]),
          ) as BuiltList<TaskGet>;
          result.tasks.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaskGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskGetBuilder();
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

