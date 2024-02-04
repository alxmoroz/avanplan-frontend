//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/account_get.dart';
import 'package:openapi/src/model/source_get.dart';
import 'package:openapi/src/model/settings_get.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/estimate_value_get.dart';
import 'package:openapi/src/model/invoice_get.dart';
import 'package:openapi/src/model/user.dart';
import 'package:openapi/src/model/role_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workspace_get.g.dart';

/// WorkspaceGet
///
/// Properties:
/// * [id] 
/// * [createdOn] 
/// * [title] 
/// * [description] 
/// * [code] 
/// * [type] 
/// * [users] 
/// * [roles] 
/// * [invoice] 
/// * [balance] 
/// * [mainAccount] 
/// * [settings] 
/// * [estimateValues] 
/// * [sources] 
@BuiltValue()
abstract class WorkspaceGet implements Built<WorkspaceGet, WorkspaceGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'created_on')
  DateTime? get createdOn;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'type')
  String? get type;

  @BuiltValueField(wireName: r'users')
  BuiltList<User>? get users;

  @BuiltValueField(wireName: r'roles')
  BuiltList<RoleGet>? get roles;

  @BuiltValueField(wireName: r'invoice')
  InvoiceGet? get invoice;

  @BuiltValueField(wireName: r'balance')
  num? get balance;

  @BuiltValueField(wireName: r'main_account')
  AccountGet? get mainAccount;

  @BuiltValueField(wireName: r'settings')
  SettingsGet? get settings;

  @BuiltValueField(wireName: r'estimate_values')
  BuiltList<EstimateValueGet>? get estimateValues;

  @BuiltValueField(wireName: r'sources')
  BuiltList<SourceGet>? get sources;

  WorkspaceGet._();

  factory WorkspaceGet([void updates(WorkspaceGetBuilder b)]) = _$WorkspaceGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkspaceGetBuilder b) => b
      ..type = 'PRIVATE'
      ..balance = 0;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkspaceGet> get serializer => _$WorkspaceGetSerializer();
}

class _$WorkspaceGetSerializer implements PrimitiveSerializer<WorkspaceGet> {
  @override
  final Iterable<Type> types = const [WorkspaceGet, _$WorkspaceGet];

  @override
  final String wireName = r'WorkspaceGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkspaceGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    if (object.createdOn != null) {
      yield r'created_on';
      yield serializers.serialize(
        object.createdOn,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(String),
      );
    }
    if (object.users != null) {
      yield r'users';
      yield serializers.serialize(
        object.users,
        specifiedType: const FullType(BuiltList, [FullType(User)]),
      );
    }
    if (object.roles != null) {
      yield r'roles';
      yield serializers.serialize(
        object.roles,
        specifiedType: const FullType(BuiltList, [FullType(RoleGet)]),
      );
    }
    if (object.invoice != null) {
      yield r'invoice';
      yield serializers.serialize(
        object.invoice,
        specifiedType: const FullType(InvoiceGet),
      );
    }
    if (object.balance != null) {
      yield r'balance';
      yield serializers.serialize(
        object.balance,
        specifiedType: const FullType(num),
      );
    }
    if (object.mainAccount != null) {
      yield r'main_account';
      yield serializers.serialize(
        object.mainAccount,
        specifiedType: const FullType(AccountGet),
      );
    }
    if (object.settings != null) {
      yield r'settings';
      yield serializers.serialize(
        object.settings,
        specifiedType: const FullType(SettingsGet),
      );
    }
    if (object.estimateValues != null) {
      yield r'estimate_values';
      yield serializers.serialize(
        object.estimateValues,
        specifiedType: const FullType(BuiltList, [FullType(EstimateValueGet)]),
      );
    }
    if (object.sources != null) {
      yield r'sources';
      yield serializers.serialize(
        object.sources,
        specifiedType: const FullType(BuiltList, [FullType(SourceGet)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkspaceGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WorkspaceGetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'created_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdOn = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'users':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(User)]),
          ) as BuiltList<User>;
          result.users.replace(valueDes);
          break;
        case r'roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(RoleGet)]),
          ) as BuiltList<RoleGet>;
          result.roles.replace(valueDes);
          break;
        case r'invoice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(InvoiceGet),
          ) as InvoiceGet;
          result.invoice.replace(valueDes);
          break;
        case r'balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.balance = valueDes;
          break;
        case r'main_account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountGet),
          ) as AccountGet;
          result.mainAccount.replace(valueDes);
          break;
        case r'settings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SettingsGet),
          ) as SettingsGet;
          result.settings.replace(valueDes);
          break;
        case r'estimate_values':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EstimateValueGet)]),
          ) as BuiltList<EstimateValueGet>;
          result.estimateValues.replace(valueDes);
          break;
        case r'sources':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SourceGet)]),
          ) as BuiltList<SourceGet>;
          result.sources.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkspaceGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkspaceGetBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

