//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

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
/// * [dueDate] 
/// * [assignee] 
/// * [author] 
/// * [priority] 
/// * [status] 
/// * [taskSource] 
/// * [tasks] 
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

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TaskGetBuilder b) => b
        ..closed = false;

    factory TaskGet([void updates(TaskGetBuilder b)]) = _$TaskGet;

    @BuiltValueSerializer(custom: true)
    static Serializer<TaskGet> get serializer => _$TaskGetSerializer();
}

class _$TaskGetSerializer implements StructuredSerializer<TaskGet> {
    @override
    final Iterable<Type> types = const [TaskGet, _$TaskGet];

    @override
    final String wireName = r'TaskGet';

    @override
    Iterable<Object?> serialize(Serializers serializers, TaskGet object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(int)));
        result
            ..add(r'created_on')
            ..add(serializers.serialize(object.createdOn,
                specifiedType: const FullType(DateTime)));
        result
            ..add(r'updated_on')
            ..add(serializers.serialize(object.updatedOn,
                specifiedType: const FullType(DateTime)));
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
        if (object.assignee != null) {
            result
                ..add(r'assignee')
                ..add(serializers.serialize(object.assignee,
                    specifiedType: const FullType(PersonGet)));
        }
        if (object.author != null) {
            result
                ..add(r'author')
                ..add(serializers.serialize(object.author,
                    specifiedType: const FullType(PersonGet)));
        }
        if (object.priority != null) {
            result
                ..add(r'priority')
                ..add(serializers.serialize(object.priority,
                    specifiedType: const FullType(PriorityGet)));
        }
        if (object.status != null) {
            result
                ..add(r'status')
                ..add(serializers.serialize(object.status,
                    specifiedType: const FullType(StatusGet)));
        }
        if (object.taskSource != null) {
            result
                ..add(r'task_source')
                ..add(serializers.serialize(object.taskSource,
                    specifiedType: const FullType(TaskSourceGet)));
        }
        if (object.tasks != null) {
            result
                ..add(r'tasks')
                ..add(serializers.serialize(object.tasks,
                    specifiedType: const FullType(BuiltList, [FullType(TaskGet)])));
        }
        return result;
    }

    @override
    TaskGet deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TaskGetBuilder();

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
                case r'assignee':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(PersonGet)) as PersonGet;
                    result.assignee.replace(valueDes);
                    break;
                case r'author':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(PersonGet)) as PersonGet;
                    result.author.replace(valueDes);
                    break;
                case r'priority':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(PriorityGet)) as PriorityGet;
                    result.priority.replace(valueDes);
                    break;
                case r'status':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(StatusGet)) as StatusGet;
                    result.status.replace(valueDes);
                    break;
                case r'task_source':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(TaskSourceGet)) as TaskSourceGet;
                    result.taskSource.replace(valueDes);
                    break;
                case r'tasks':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(TaskGet)])) as BuiltList<TaskGet>;
                    result.tasks.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

