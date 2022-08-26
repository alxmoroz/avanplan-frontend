//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:openapi/src/model/priority_get.dart';
import 'package:openapi/src/model/source_get.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/person_get.dart';
import 'package:openapi/src/model/status_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workspace_get.g.dart';

/// WorkspaceGet
///
/// Properties:
/// * [id] 
/// * [title] 
/// * [description] 
/// * [statuses] 
/// * [priorities] 
/// * [persons] 
/// * [sources] 
abstract class WorkspaceGet implements Built<WorkspaceGet, WorkspaceGetBuilder> {
    @BuiltValueField(wireName: r'id')
    int get id;

    @BuiltValueField(wireName: r'title')
    String get title;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'statuses')
    BuiltList<StatusGet> get statuses;

    @BuiltValueField(wireName: r'priorities')
    BuiltList<PriorityGet> get priorities;

    @BuiltValueField(wireName: r'persons')
    BuiltList<PersonGet> get persons;

    @BuiltValueField(wireName: r'sources')
    BuiltList<SourceGet> get sources;

    WorkspaceGet._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(WorkspaceGetBuilder b) => b;

    factory WorkspaceGet([void updates(WorkspaceGetBuilder b)]) = _$WorkspaceGet;

    @BuiltValueSerializer(custom: true)
    static Serializer<WorkspaceGet> get serializer => _$WorkspaceGetSerializer();
}

class _$WorkspaceGetSerializer implements StructuredSerializer<WorkspaceGet> {
    @override
    final Iterable<Type> types = const [WorkspaceGet, _$WorkspaceGet];

    @override
    final String wireName = r'WorkspaceGet';

    @override
    Iterable<Object?> serialize(Serializers serializers, WorkspaceGet object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(int)));
        result
            ..add(r'title')
            ..add(serializers.serialize(object.title,
                specifiedType: const FullType(String)));
        if (object.description != null) {
            result
                ..add(r'description')
                ..add(serializers.serialize(object.description,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'statuses')
            ..add(serializers.serialize(object.statuses,
                specifiedType: const FullType(BuiltList, [FullType(StatusGet)])));
        result
            ..add(r'priorities')
            ..add(serializers.serialize(object.priorities,
                specifiedType: const FullType(BuiltList, [FullType(PriorityGet)])));
        result
            ..add(r'persons')
            ..add(serializers.serialize(object.persons,
                specifiedType: const FullType(BuiltList, [FullType(PersonGet)])));
        result
            ..add(r'sources')
            ..add(serializers.serialize(object.sources,
                specifiedType: const FullType(BuiltList, [FullType(SourceGet)])));
        return result;
    }

    @override
    WorkspaceGet deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = WorkspaceGetBuilder();

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
                case r'title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.title = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'statuses':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(StatusGet)])) as BuiltList<StatusGet>;
                    result.statuses.replace(valueDes);
                    break;
                case r'priorities':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(PriorityGet)])) as BuiltList<PriorityGet>;
                    result.priorities.replace(valueDes);
                    break;
                case r'persons':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(PersonGet)])) as BuiltList<PersonGet>;
                    result.persons.replace(valueDes);
                    break;
                case r'sources':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(SourceGet)])) as BuiltList<SourceGet>;
                    result.sources.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

