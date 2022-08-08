//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'token.g.dart';

/// Token
///
/// Properties:
/// * [accessToken] 
/// * [tokenType] 
abstract class Token implements Built<Token, TokenBuilder> {
    @BuiltValueField(wireName: r'access_token')
    String get accessToken;

    @BuiltValueField(wireName: r'token_type')
    String get tokenType;

    Token._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TokenBuilder b) => b;

    factory Token([void updates(TokenBuilder b)]) = _$Token;

    @BuiltValueSerializer(custom: true)
    static Serializer<Token> get serializer => _$TokenSerializer();
}

class _$TokenSerializer implements StructuredSerializer<Token> {
    @override
    final Iterable<Type> types = const [Token, _$Token];

    @override
    final String wireName = r'Token';

    @override
    Iterable<Object?> serialize(Serializers serializers, Token object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'access_token')
            ..add(serializers.serialize(object.accessToken,
                specifiedType: const FullType(String)));
        result
            ..add(r'token_type')
            ..add(serializers.serialize(object.tokenType,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    Token deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TokenBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'access_token':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.accessToken = valueDes;
                    break;
                case r'token_type':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.tokenType = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

