//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'status_get.g.dart';

/// StatusGet
///
/// Properties:
/// * [id] 
/// * [workspaceId] 
/// * [closed] 
/// * [title] 
abstract class StatusGet implements Built<StatusGet, StatusGetBuilder> {
    @BuiltValueField(wireName: r'id')
    int get id;

    @BuiltValueField(wireName: r'workspace_id')
    int get workspaceId;

    @BuiltValueField(wireName: r'closed')
    bool get closed;

    @BuiltValueField(wireName: r'title')
    String get title;

    StatusGet._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(StatusGetBuilder b) => b;

    factory StatusGet([void updates(StatusGetBuilder b)]) = _$StatusGet;

    @BuiltValueSerializer(custom: true)
    static Serializer<StatusGet> get serializer => _$StatusGetSerializer();
}

class _$StatusGetSerializer implements StructuredSerializer<StatusGet> {
    @override
    final Iterable<Type> types = const [StatusGet, _$StatusGet];

    @override
    final String wireName = r'StatusGet';

    @override
    Iterable<Object?> serialize(Serializers serializers, StatusGet object,
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
            ..add(r'closed')
            ..add(serializers.serialize(object.closed,
                specifiedType: const FullType(bool)));
        result
            ..add(r'title')
            ..add(serializers.serialize(object.title,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    StatusGet deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = StatusGetBuilder();

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
                case r'closed':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.closed = valueDes;
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

