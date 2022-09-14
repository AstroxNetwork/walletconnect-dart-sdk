// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ICConnectedPayload _$ICConnectedPayloadFromJson(Map<String, dynamic> json) =>
    ICConnectedPayload(
      ICDelegationChain.fromJson(
          json['delegationChain'] as Map<String, dynamic>),
      ICWalletAddress.fromJson(json['wallet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ICConnectedPayloadToJson(ICConnectedPayload instance) =>
    <String, dynamic>{
      'delegationChain': instance.delegationChain,
      'wallet': instance.wallet,
    };

ICDelegationChain _$ICDelegationChainFromJson(Map<String, dynamic> json) =>
    ICDelegationChain(
      publicKey: json['publicKey'] as String,
      delegations: (json['delegations'] as List<dynamic>)
          .map((e) => ICSignedDelegation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ICDelegationChainToJson(ICDelegationChain instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'delegations': instance.delegations,
    };

ICSignedDelegation _$ICSignedDelegationFromJson(Map<String, dynamic> json) =>
    ICSignedDelegation(
      signature: json['signature'] as String?,
      delegation: json['delegation'] == null
          ? null
          : ICDelegation.fromJson(json['delegation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ICSignedDelegationToJson(ICSignedDelegation instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'delegation': instance.delegation,
    };

ICDelegation _$ICDelegationFromJson(Map<String, dynamic> json) => ICDelegation(
      expiration: json['expiration'] as String,
      publicKey: json['pubkey'] as String,
      targets:
          (json['targets'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ICDelegationToJson(ICDelegation instance) =>
    <String, dynamic>{
      'expiration': instance.expiration,
      'pubkey': instance.publicKey,
      'targets': instance.targets,
    };

ICWalletAddress _$ICWalletAddressFromJson(Map<String, dynamic> json) =>
    ICWalletAddress(
      principal: json['principal'] as String,
      accountId: json['accountId'] as String,
    );

Map<String, dynamic> _$ICWalletAddressToJson(ICWalletAddress instance) =>
    <String, dynamic>{
      'principal': instance.principal,
      'accountId': instance.accountId,
    };

ICTransferRequest _$ICTransferRequestFromJson(Map<String, dynamic> json) =>
    ICTransferRequest(
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

Map<String, dynamic> _$ICTransferRequestToJson(ICTransferRequest instance) =>
    <String, dynamic>{
      'to': instance.to,
      'amount': instance.amount?.toString(),
      'symbol': instance.symbol,
      'standard': instance.standard,
      'canisterId': instance.canisterId,
      'tokenIndex': instance.tokenIndex,
      'tokenIdentifier': instance.tokenIdentifier,
    };
