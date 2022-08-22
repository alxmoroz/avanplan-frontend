//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:openapi/src/model/person.dart';
import 'package:openapi/src/model/status.dart';
import 'package:openapi/src/model/priority.dart';
import 'package:openapi/src/model/task_source.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task.g.dart';

/// Task
///
/// Properties:
/// * [title] 
/// * [closed] 
/// * [description] 
/// * [dueDate] 
/// * [assignee] 
/// * [author] 
/// * [status] 
/// * [priority] 
/// * [taskSource] 
/// * [createdOn] 
/// * [updatedOn] 
abstract class Task implements Built<Task, TaskBuilder> {
    @BuiltValueField(wireName: r'title')
    String get title;

    @BuiltValueField(wireName: r'closed')
    bool? get closed;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'due_date')
    DateTime? get dueDate;

    @BuiltValueField(wireName: r'assignee')
    Person? get assignee;

    @BuiltValueField(wireName: r'author')
    Person? get author;

    @BuiltValueField(wireName: r'status')
    Status? get status;

    @BuiltValueField(wireName: r'priority')
    Priority? get priority;

    @BuiltValueField(wireName: r'task_source')
    TaskSource? get taskSource;

    @BuiltValueField(wireName: r'created_on')
    DateTime? get createdOn;

    @BuiltValueField(wireName: r'updated_on')
    DateTime? get updatedOn;

    Task._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TaskBuilder b) => b
        ..closed = false;

    factory Task([void updates(TaskBuilder b)]) = _$Task;

    @BuiltValueSerializer(custom: true)
    static Serializer<Task> get serializer => _$TaskSerializer();
}

class _$TaskSerializer implements StructuredSerializer<Task> {
    @override
    final Iterable<Type> types = const [Task, _$Task];

    @override
    final String wireName = r'Task';

    @override
    Iterable<Object?> serialize(Serializers serializers, Task object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
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
                    specifiedType: const FullType(Person)));
        }
        if (object.author != null) {
            result
                ..add(r'author')
                ..add(serializers.serialize(object.author,
                    specifiedType: const FullType(Person)));
        }
        if (object.status != null) {
            result
                ..add(r'status')
                ..add(serializers.serialize(object.status,
                    specifiedType: const FullType(Status)));
        }
        if (object.priority != null) {
            result
                ..add(r'priority')
                ..add(serializers.serialize(object.priority,
                    specifiedType: const FullType(Priority)));
        }
        if (object.taskSource != null) {
            result
                ..add(r'task_source')
                ..add(serializers.serialize(object.taskSource,
                    specifiedType: const FullType(TaskSource)));
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
        return result;
    }

    @override
    Task deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TaskBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
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
                        specifiedType: const FullType(Person)) as Person;
                    result.assignee.replace(valueDes);
                    break;
                case r'author':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(Person)) as Person;
                    result.author.replace(valueDes);
                    break;
                case r'status':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(Status)) as Status;
                    result.status.replace(valueDes);
                    break;
                case r'priority':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(Priority)) as Priority;
                    result.priority.replace(valueDes);
                    break;
                case r'task_source':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(TaskSource)) as TaskSource;
                    result.taskSource.replace(valueDes);
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
            }
        }
        return result.build();
    }
}

