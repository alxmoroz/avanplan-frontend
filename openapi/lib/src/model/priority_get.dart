//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'priority_get.g.dart';

/// PriorityGet
///
/// Properties:
/// * [id] 
/// * [workspaceId] 
/// * [order] 
/// * [title] 
abstract class PriorityGet implements Built<PriorityGet, PriorityGetBuilder> {
    @BuiltValueField(wireName: r'id')
    int get id;

    @BuiltValueField(wireName: r'workspace_id')
    int get workspaceId;

    @BuiltValueField(wireName: r'order')
    int get order;

    @BuiltValueField(wireName: r'title')
    String get title;

    PriorityGet._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PriorityGetBuilder b) => b;

    factory PriorityGet([void updates(PriorityGetBuilder b)]) = _$PriorityGet;

    @BuiltValueSerializer(custom: true)
    static Serializer<PriorityGet> get serializer => _$PriorityGetSerializer();
}

class _$PriorityGetSerializer implements StructuredSerializer<PriorityGet> {
    @override
    final Iterable<Type> types = const [PriorityGet, _$PriorityGet];

    @override
    final String wireName = r'PriorityGet';

    @override
    Iterable<Object?> serialize(Serializers serializers, PriorityGet object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(int)));
        result
            ..add(r'workspace_id')
            ..add(serializers.serialize(object.workspaceId,
                specifiedType: const FullType(int)));
        result
            ..add(r'order')
            ..add(serializers.serialize(object.order,
                specifiedType: const FullType(int)));
        result
            ..add(r'title')
            ..add(serializers.serialize(object.title,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    PriorityGet deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PriorityGetBuilder();

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
                case r'order':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.order = valueDes;
                    break;
                case r'title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.title = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

