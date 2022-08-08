//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'status.g.dart';

/// Status
///
/// Properties:
/// * [closed] 
/// * [title] 
abstract class Status implements Built<Status, StatusBuilder> {
    @BuiltValueField(wireName: r'closed')
    bool get closed;

    @BuiltValueField(wireName: r'title')
    String get title;

    Status._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(StatusBuilder b) => b;

    factory Status([void updates(StatusBuilder b)]) = _$Status;

    @BuiltValueSerializer(custom: true)
    static Serializer<Status> get serializer => _$StatusSerializer();
}

class _$StatusSerializer implements StructuredSerializer<Status> {
    @override
    final Iterable<Type> types = const [Status, _$Status];

    @override
    final String wireName = r'Status';

    @override
    Iterable<Object?> serialize(Serializers serializers, Status object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
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
    Status deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = StatusBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
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

