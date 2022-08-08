//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_upsert.g.dart';

/// TaskUpsert
///
/// Properties:
/// * [id] 
/// * [workspaceId] 
/// * [title] 
/// * [closed] 
/// * [description] 
/// * [dueDate] 
/// * [createdOn] 
/// * [updatedOn] 
/// * [assigneeId] 
/// * [authorId] 
/// * [priorityId] 
/// * [statusId] 
/// * [parentId] 
/// * [taskSourceId] 
abstract class TaskUpsert implements Built<TaskUpsert, TaskUpsertBuilder> {
    @BuiltValueField(wireName: r'id')
    int? get id;

    @BuiltValueField(wireName: r'workspace_id')
    int get workspaceId;

    @BuiltValueField(wireName: r'title')
    String get title;

    @BuiltValueField(wireName: r'closed')
    bool? get closed;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'due_date')
    DateTime? get dueDate;

    @BuiltValueField(wireName: r'created_on')
    DateTime? get createdOn;

    @BuiltValueField(wireName: r'updated_on')
    DateTime? get updatedOn;

    @BuiltValueField(wireName: r'assignee_id')
    int? get assigneeId;

    @BuiltValueField(wireName: r'author_id')
    int? get authorId;

    @BuiltValueField(wireName: r'priority_id')
    int? get priorityId;

    @BuiltValueField(wireName: r'status_id')
    int? get statusId;

    @BuiltValueField(wireName: r'parent_id')
    int? get parentId;

    @BuiltValueField(wireName: r'task_source_id')
    int? get taskSourceId;

    TaskUpsert._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TaskUpsertBuilder b) => b
        ..closed = false;

    factory TaskUpsert([void updates(TaskUpsertBuilder b)]) = _$TaskUpsert;

    @BuiltValueSerializer(custom: true)
    static Serializer<TaskUpsert> get serializer => _$TaskUpsertSerializer();
}

class _$TaskUpsertSerializer implements StructuredSerializer<TaskUpsert> {
    @override
    final Iterable<Type> types = const [TaskUpsert, _$TaskUpsert];

    @override
    final String wireName = r'TaskUpsert';

    @override
    Iterable<Object?> serialize(Serializers serializers, TaskUpsert object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(int)));
        }
        result
            ..add(r'workspace_id')
            ..add(serializers.serialize(object.workspaceId,
                specifiedType: const FullType(int)));
        result
            ..add(r'title')
            ..add(serializers.serialize(object.title,
                specifiedType: const FullType(String)));
        if (object.closed != null) {
            result
                ..add(r'closed')
                ..add(serializers.serialize(object.closed,
                    specifiedType: const FullType(bool)));
        }
        if (object.description != null) {
            result
                ..add(r'description')
                ..add(serializers.serialize(object.description,
                    specifiedType: const FullType(String)));
        }
        if (object.dueDate != null) {
            result
                ..add(r'due_date')
                ..add(serializers.serialize(object.dueDate,
                    specifiedType: const FullType(DateTime)));
        }
        if (object.createdOn != null) {
            result
                ..add(r'created_on')
                ..add(serializers.serialize(object.createdOn,
                    specifiedType: const FullType(DateTime)));
        }
        if (object.updatedOn != null) {
            result
                ..add(r'updated_on')
                ..add(serializers.serialize(object.updatedOn,
                    specifiedType: const FullType(DateTime)));
        }
        if (object.assigneeId != null) {
            result
                ..add(r'assignee_id')
                ..add(serializers.serialize(object.assigneeId,
                    specifiedType: const FullType(int)));
        }
        if (object.authorId != null) {
            result
                ..add(r'author_id')
                ..add(serializers.serialize(object.authorId,
                    specifiedType: const FullType(int)));
        }
        if (object.priorityId != null) {
            result
                ..add(r'priority_id')
                ..add(serializers.serialize(object.priorityId,
                    specifiedType: const FullType(int)));
        }
        if (object.statusId != null) {
            result
                ..add(r'status_id')
                ..add(serializers.serialize(object.statusId,
                    specifiedType: const FullType(int)));
        }
        if (object.parentId != null) {
            result
                ..add(r'parent_id')
                ..add(serializers.serialize(object.parentId,
                    specifiedType: const FullType(int)));
        }
        if (object.taskSourceId != null) {
            result
                ..add(r'task_source_id')
                ..add(serializers.serialize(object.taskSourceId,
                    specifiedType: const FullType(int)));
        }
        return result;
    }

    @override
    TaskUpsert deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TaskUpsertBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.id = valueDes;
                    break;
                case r'workspace_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.workspaceId = valueDes;
                    break;
                case r'title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.title = valueDes;
                    break;
                case r'closed':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.closed = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'due_date':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    result.dueDate = valueDes;
                    break;
                case r'created_on':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    result.createdOn = valueDes;
                    break;
                case r'updated_on':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    result.updatedOn = valueDes;
                    break;
                case r'assignee_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.assigneeId = valueDes;
                    break;
                case r'author_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.authorId = valueDes;
                    break;
                case r'priority_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.priorityId = valueDes;
                    break;
                case r'status_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.statusId = valueDes;
                    break;
                case r'parent_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.parentId = valueDes;
                    break;
                case r'task_source_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.taskSourceId = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

