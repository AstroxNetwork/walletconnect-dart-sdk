// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      principal: json['principal'] as String,
      accountId: json['accountId'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'principal': instance.principal,
      'accountId': instance.accountId,
    };

TransferRequest _$TransferRequestFromJson(Map<String, dynamic> json) =>
    TransferRequest(
      to: json['to'] as String,
      standard: json['standard'] as String,
      amount: json['amount'] == null
          ? null
          : BigInt.parse(json['amount'] as String),
      symbol: json['symbol'] as String?,
      canisterId: json['canisterId'] as String?,
      tokenIndex: json['tokenIndex'] as int?,
      tokenIdentifier: json['tokenIdentifier'] as String?,
    );

Map<String, dynamic> _$TransferRequestToJson(TransferRequest instance) =>
    <String, dynamic>{
      'to': instance.to,
      'amount': instance.amount?.toString(),
      'symbol': instance.symbol,
      'standard': instance.standard,
      'canisterId': instance.canisterId,
      'tokenIndex': instance.tokenIndex,
      'tokenIdentifier': instance.tokenIdentifier,
    };
