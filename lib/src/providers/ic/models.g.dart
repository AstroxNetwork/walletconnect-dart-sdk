// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ICConnectRequest _$ICConnectRequestFromJson(Map json) => ICConnectRequest(
      accountId: json['accountId'] as String,
      publicKey: json['publicKey'] as String,
      delegationTargets: (json['delegationTargets'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      host: json['host'] as String,
      noUnify: json['noUnify'] as bool? ?? false,
    );

Map<String, dynamic> _$ICConnectRequestToJson(ICConnectRequest instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'delegationTargets': instance.delegationTargets,
      'host': instance.host,
      'noUnify': instance.noUnify,
      'accountId': instance.accountId,
    };

ICConnectResponse _$ICConnectResponseFromJson(Map json) => ICConnectResponse(
      delegationChain: ICDelegationChain.fromJson(
          Map<String, dynamic>.from(json['delegationChain'] as Map)),
      wallet: ICWalletAddressResponse.fromJson(
          Map<String, dynamic>.from(json['wallet'] as Map)),
    );

Map<String, dynamic> _$ICConnectResponseToJson(ICConnectResponse instance) =>
    <String, dynamic>{
      'delegationChain': instance.delegationChain.toJson(),
      'wallet': instance.wallet.toJson(),
    };

ICDelegationChain _$ICDelegationChainFromJson(Map json) => ICDelegationChain(
      publicKey: json['publicKey'] as String,
      delegations: (json['delegations'] as List<dynamic>)
          .map((e) =>
              ICSignedDelegation.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$ICDelegationChainToJson(ICDelegationChain instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'delegations': instance.delegations.map((e) => e.toJson()).toList(),
    };

ICSignedDelegation _$ICSignedDelegationFromJson(Map json) => ICSignedDelegation(
      signature: json['signature'] as String?,
      delegation: json['delegation'] == null
          ? null
          : ICDelegation.fromJson(
              Map<String, dynamic>.from(json['delegation'] as Map)),
    );

Map<String, dynamic> _$ICSignedDelegationToJson(ICSignedDelegation instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'delegation': instance.delegation?.toJson(),
    };

ICDelegation _$ICDelegationFromJson(Map json) => ICDelegation(
      expiration: BigInt.parse(json['expiration'] as String),
      publicKey: json['pubkey'] as String,
      targets:
          (json['targets'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ICDelegationToJson(ICDelegation instance) =>
    <String, dynamic>{
      'expiration': instance.expiration.toString(),
      'pubkey': instance.publicKey,
      'targets': instance.targets,
    };

ICWalletAddressResponse _$ICWalletAddressResponseFromJson(Map json) =>
    ICWalletAddressResponse(
      principal: json['principal'] as String,
      accountId: json['accountId'] as String,
    );

Map<String, dynamic> _$ICWalletAddressResponseToJson(
        ICWalletAddressResponse instance) =>
    <String, dynamic>{
      'principal': instance.principal,
      'accountId': instance.accountId,
    };

ICTransferRequest _$ICTransferRequestFromJson(Map json) => ICTransferRequest(
      from: json['from'] as String,
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
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount?.toString(),
      'symbol': instance.symbol,
      'standard': instance.standard,
      'canisterId': instance.canisterId,
      'tokenIndex': instance.tokenIndex,
      'tokenIdentifier': instance.tokenIdentifier,
    };

ICTransferResponse _$ICTransferResponseFromJson(Map json) => ICTransferResponse(
      blockHeight: json['blockHeight'] == null
          ? null
          : BigInt.parse(json['blockHeight'] as String),
      amount: json['amount'] as String,
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$ICTransferResponseToJson(ICTransferResponse instance) =>
    <String, dynamic>{
      'blockHeight': instance.blockHeight?.toString(),
      'amount': instance.amount,
      'transactionId': instance.transactionId,
    };

ICTransferToken _$ICTransferTokenFromJson(Map json) => ICTransferToken(
      from: json['from'] as String,
      to: json['to'] as String,
      amount: BigInt.parse(json['amount'] as String),
      symbol: json['symbol'] as String,
      standard: json['standard'] as String,
    );

Map<String, dynamic> _$ICTransferTokenToJson(ICTransferToken instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount.toString(),
      'symbol': instance.symbol,
      'standard': instance.standard,
    };

ICTransferNFT _$ICTransferNFTFromJson(Map json) => ICTransferNFT(
      from: json['from'] as String,
      to: json['to'] as String,
      standard: json['standard'] as String,
      canisterId: json['canisterId'] as String,
      tokenIndex: json['tokenIndex'] as int,
      tokenIdentifier: json['tokenIdentifier'] as String,
    );

Map<String, dynamic> _$ICTransferNFTToJson(ICTransferNFT instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'standard': instance.standard,
      'canisterId': instance.canisterId,
      'tokenIndex': instance.tokenIndex,
      'tokenIdentifier': instance.tokenIdentifier,
    };
