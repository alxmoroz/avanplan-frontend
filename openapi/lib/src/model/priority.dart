//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'priority.g.dart';

/// Priority
///
/// Properties:
/// * [order] 
/// * [title] 
abstract class Priority implements Built<Priority, PriorityBuilder> {
    @BuiltValueField(wireName: r'order')
    int get order;

    @BuiltValueField(wireName: r'title')
    String get title;

    Priority._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PriorityBuilder b) => b;

    factory Priority([void updates(PriorityBuilder b)]) = _$Priority;

    @BuiltValueSerializer(custom: true)
    static Serializer<Priority> get serializer => _$PrioritySerializer();
}

class _$PrioritySerializer implements StructuredSerializer<Priority> {
    @override
    final Iterable<Type> types = const [Priority, _$Priority];

    @override
    final String wireName = r'Priority';

    @override
    Iterable<Object?> serialize(Serializers serializers, Priority object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
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
    Priority deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PriorityBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
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

