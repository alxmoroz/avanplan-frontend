//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/member_get.dart';
import 'package:openapi/src/model/task_source_get.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/project_status_get.dart';
import 'package:openapi/src/model/attachment_get.dart';
import 'package:openapi/src/model/project_feature_set_get.dart';
import 'package:openapi/src/model/note_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_get.g.dart';

/// TaskGet
///
/// Properties:
/// * [id] 
/// * [title] 
/// * [description] 
/// * [closed] 
/// * [type] 
/// * [startDate] 
/// * [dueDate] 
/// * [closedDate] 
/// * [estimate] 
/// * [createdOn] 
/// * [updatedOn] 
/// * [parentId] 
/// * [assigneeId] 
/// * [authorId] 
/// * [projectStatusId] 
/// * [taskSourceId] 
/// * [state] 
/// * [velocity] 
/// * [requiredVelocity] 
/// * [progress] 
/// * [etaDate] 
/// * [openedVolume] 
/// * [closedVolume] 
/// * [closedSubtasksCount] 
/// * [taskSource] 
/// * [members] 
/// * [notes] 
/// * [attachments] 
/// * [projectStatuses] 
/// * [projectFeatureSets] 
@BuiltValue()
abstract class TaskGet implements Built<TaskGet, TaskGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'title')
  String get title;

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
  num? get estimate;

  @BuiltValueField(wireName: r'created_on')
  DateTime get createdOn;

  @BuiltValueField(wireName: r'updated_on')
  DateTime get updatedOn;

  @BuiltValueField(wireName: r'parent_id')
  int? get parentId;

  @BuiltValueField(wireName: r'assignee_id')
  int? get assigneeId;

  @BuiltValueField(wireName: r'author_id')
  int? get authorId;

  @BuiltValueField(wireName: r'project_status_id')
  int? get projectStatusId;

  @BuiltValueField(wireName: r'task_source_id')
  int? get taskSourceId;

  @BuiltValueField(wireName: r'state')
  String? get state;

  @BuiltValueField(wireName: r'velocity')
  num? get velocity;

  @BuiltValueField(wireName: r'required_velocity')
  num? get requiredVelocity;

  @BuiltValueField(wireName: r'progress')
  num? get progress;

  @BuiltValueField(wireName: r'eta_date')
  DateTime? get etaDate;

  @BuiltValueField(wireName: r'opened_volume')
  num? get openedVolume;

  @BuiltValueField(wireName: r'closed_volume')
  num? get closedVolume;

  @BuiltValueField(wireName: r'closed_subtasks_count')
  int? get closedSubtasksCount;

  @BuiltValueField(wireName: r'task_source')
  TaskSourceGet? get taskSource;

  @BuiltValueField(wireName: r'members')
  BuiltList<MemberGet>? get members;

  @BuiltValueField(wireName: r'notes')
  BuiltList<NoteGet>? get notes;

  @BuiltValueField(wireName: r'attachments')
  BuiltList<AttachmentGet>? get attachments;

  @BuiltValueField(wireName: r'project_statuses')
  BuiltList<ProjectStatusGet>? get projectStatuses;

  @BuiltValueField(wireName: r'project_feature_sets')
  BuiltList<ProjectFeatureSetGet>? get projectFeatureSets;

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
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
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
        specifiedType: const FullType(num),
      );
    }
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
    if (object.parentId != null) {
      yield r'parent_id';
      yield serializers.serialize(
        object.parentId,
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
    if (object.projectStatusId != null) {
      yield r'project_status_id';
      yield serializers.serialize(
        object.projectStatusId,
        specifiedType: const FullType(int),
      );
    }
    if (object.taskSourceId != null) {
      yield r'task_source_id';
      yield serializers.serialize(
        object.taskSourceId,
        specifiedType: const FullType(int),
      );
    }
    if (object.state != null) {
      yield r'state';
      yield serializers.serialize(
        object.state,
        specifiedType: const FullType(String),
      );
    }
    if (object.velocity != null) {
      yield r'velocity';
      yield serializers.serialize(
        object.velocity,
        specifiedType: const FullType(num),
      );
    }
    if (object.requiredVelocity != null) {
      yield r'required_velocity';
      yield serializers.serialize(
        object.requiredVelocity,
        specifiedType: const FullType(num),
      );
    }
    if (object.progress != null) {
      yield r'progress';
      yield serializers.serialize(
        object.progress,
        specifiedType: const FullType(num),
      );
    }
    if (object.etaDate != null) {
      yield r'eta_date';
      yield serializers.serialize(
        object.etaDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.openedVolume != null) {
      yield r'opened_volume';
      yield serializers.serialize(
        object.openedVolume,
        specifiedType: const FullType(num),
      );
    }
    if (object.closedVolume != null) {
      yield r'closed_volume';
      yield serializers.serialize(
        object.closedVolume,
        specifiedType: const FullType(num),
      );
    }
    if (object.closedSubtasksCount != null) {
      yield r'closed_subtasks_count';
      yield serializers.serialize(
        object.closedSubtasksCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.taskSource != null) {
      yield r'task_source';
      yield serializers.serialize(
        object.taskSource,
        specifiedType: const FullType(TaskSourceGet),
      );
    }
    if (object.members != null) {
      yield r'members';
      yield serializers.serialize(
        object.members,
        specifiedType: const FullType(BuiltList, [FullType(MemberGet)]),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType(BuiltList, [FullType(NoteGet)]),
      );
    }
    if (object.attachments != null) {
      yield r'attachments';
      yield serializers.serialize(
        object.attachments,
        specifiedType: const FullType(BuiltList, [FullType(AttachmentGet)]),
      );
    }
    if (object.projectStatuses != null) {
      yield r'project_statuses';
      yield serializers.serialize(
        object.projectStatuses,
        specifiedType: const FullType(BuiltList, [FullType(ProjectStatusGet)]),
      );
    }
    if (object.projectFeatureSets != null) {
      yield r'project_feature_sets';
      yield serializers.serialize(
        object.projectFeatureSets,
        specifiedType: const FullType(BuiltList, [FullType(ProjectFeatureSetGet)]),
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
            specifiedType: const FullType(num),
          ) as num;
          result.estimate = valueDes;
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
        case r'parent_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.parentId = valueDes;
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
        case r'project_status_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.projectStatusId = valueDes;
          break;
        case r'task_source_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.taskSourceId = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.state = valueDes;
          break;
        case r'velocity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.velocity = valueDes;
          break;
        case r'required_velocity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.requiredVelocity = valueDes;
          break;
        case r'progress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.progress = valueDes;
          break;
        case r'eta_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.etaDate = valueDes;
          break;
        case r'opened_volume':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.openedVolume = valueDes;
          break;
        case r'closed_volume':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.closedVolume = valueDes;
          break;
        case r'closed_subtasks_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.closedSubtasksCount = valueDes;
          break;
        case r'task_source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TaskSourceGet),
          ) as TaskSourceGet;
          result.taskSource.replace(valueDes);
          break;
        case r'members':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MemberGet)]),
          ) as BuiltList<MemberGet>;
          result.members.replace(valueDes);
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(NoteGet)]),
          ) as BuiltList<NoteGet>;
          result.notes.replace(valueDes);
          break;
        case r'attachments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AttachmentGet)]),
          ) as BuiltList<AttachmentGet>;
          result.attachments.replace(valueDes);
          break;
        case r'project_statuses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ProjectStatusGet)]),
          ) as BuiltList<ProjectStatusGet>;
          result.projectStatuses.replace(valueDes);
          break;
        case r'project_feature_sets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ProjectFeatureSetGet)]),
          ) as BuiltList<ProjectFeatureSetGet>;
          result.projectFeatureSets.replace(valueDes);
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

