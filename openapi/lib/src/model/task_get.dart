//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/priority_get.dart';
import 'package:openapi/src/model/member_get.dart';
import 'package:openapi/src/model/task_source_get.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/status_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_get.g.dart';

/// TaskGet
///
/// Properties:
/// * [id] 
/// * [createdOn] 
/// * [title] 
/// * [description] 
/// * [closed] 
/// * [type] 
/// * [startDate] 
/// * [dueDate] 
/// * [closedDate] 
/// * [estimate] 
/// * [assigneeId] 
/// * [authorId] 
/// * [priority] 
/// * [status] 
/// * [taskSource] 
/// * [tasks] 
/// * [members] 
/// * [parentId] 
/// * [updatedOn] 
@BuiltValue()
abstract class TaskGet implements Built<TaskGet, TaskGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'created_on')
  DateTime get createdOn;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'closed')
  bool? get closed;

  @BuiltValueField(wireName: r'type')
  String? get type;

  @BuiltValueField(wireName: r'start_date')
  DateTime? get startDate;

  @BuiltValueField(wireName: r'due_date')
  DateTime? get dueDate;

  @BuiltValueField(wireName: r'closed_date')
  DateTime? get closedDate;

  @BuiltValueField(wireName: r'estimate')
  int? get estimate;

  @BuiltValueField(wireName: r'assignee_id')
  int? get assigneeId;

  @BuiltValueField(wireName: r'author_id')
  int? get authorId;

  @BuiltValueField(wireName: r'priority')
  PriorityGet? get priority;

  @BuiltValueField(wireName: r'status')
  StatusGet? get status;

  @BuiltValueField(wireName: r'task_source')
  TaskSourceGet? get taskSource;

  @BuiltValueField(wireName: r'tasks')
  BuiltList<TaskGet>? get tasks;

  @BuiltValueField(wireName: r'members')
  BuiltList<MemberGet>? get members;

  @BuiltValueField(wireName: r'parent_id')
  int? get parentId;

  @BuiltValueField(wireName: r'updated_on')
  DateTime get updatedOn;

  TaskGet._();

  factory TaskGet([void updates(TaskGetBuilder b)]) = _$TaskGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskGetBuilder b) => b
      ..closed = false
      ..type = 'TASK';

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
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.closed != null) {
      yield r'closed';
      yield serializers.serialize(
        object.closed,
        specifiedType: const FullType(bool),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
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
    if (object.closedDate != null) {
      yield r'closed_date';
      yield serializers.serialize(
        object.closedDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.estimate != null) {
      yield r'estimate';
      yield serializers.serialize(
        object.estimate,
        specifiedType: const FullType(int),
      );
    }
    if (object.assigneeId != null) {
      yield r'assignee_id';
      yield serializers.serialize(
        object.assigneeId,
        specifiedType: const FullType(int),
      );
    }
    if (object.authorId != null) {
      yield r'author_id';
      yield serializers.serialize(
        object.authorId,
        specifiedType: const FullType(int),
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
    if (object.members != null) {
      yield r'members';
      yield serializers.serialize(
        object.members,
        specifiedType: const FullType(BuiltList, [FullType(MemberGet)]),
      );
    }
    if (object.parentId != null) {
      yield r'parent_id';
      yield serializers.serialize(
        object.parentId,
        specifiedType: const FullType(int),
      );
    }
    yield r'updated_on';
    yield serializers.serialize(
      object.updatedOn,
      specifiedType: const FullType(DateTime),
    );
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'closed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.closed = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
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
        case r'closed_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.closedDate = valueDes;
          break;
        case r'estimate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.estimate = valueDes;
          break;
        case r'assignee_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.assigneeId = valueDes;
          break;
        case r'author_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.authorId = valueDes;
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
        case r'members':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MemberGet)]),
          ) as BuiltList<MemberGet>;
          result.members.replace(valueDes);
          break;
        case r'parent_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.parentId = valueDes;
          break;
        case r'updated_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedOn = valueDes;
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

