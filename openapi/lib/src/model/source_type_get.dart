//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'source_type_get.g.dart';

/// SourceTypeGet
///
/// Properties:
/// * [id] 
/// * [title] 
abstract class SourceTypeGet implements Built<SourceTypeGet, SourceTypeGetBuilder> {
    @BuiltValueField(wireName: r'id')
    int get id;

    @BuiltValueField(wireName: r'title')
    String get title;

    SourceTypeGet._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SourceTypeGetBuilder b) => b;

    factory SourceTypeGet([void updates(SourceTypeGetBuilder b)]) = _$SourceTypeGet;

    @BuiltValueSerializer(custom: true)
    static Serializer<SourceTypeGet> get serializer => _$SourceTypeGetSerializer();
}

class _$SourceTypeGetSerializer implements StructuredSerializer<SourceTypeGet> {
    @override
    final Iterable<Type> types = const [SourceTypeGet, _$SourceTypeGet];

    @override
    final String wireName = r'SourceTypeGet';

    @override
    Iterable<Object?> serialize(Serializers serializers, SourceTypeGet object,
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
        return result;
    }

    @override
    SourceTypeGet deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SourceTypeGetBuilder();

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
            }
        }
        return result.build();
    }
}

