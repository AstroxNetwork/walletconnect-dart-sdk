// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ICConnectRequest _$ICConnectRequestFromJson(Map<String, dynamic> json) =>
    ICConnectRequest(
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

ICConnectResponse _$ICConnectResponseFromJson(Map<String, dynamic> json) =>
    ICConnectResponse(
      delegationChain: ICDelegationChain.fromJson(
          json['delegationChain'] as Map<String, dynamic>),
      wallet: ICWalletAddressResponse.fromJson(
          json['wallet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ICConnectResponseToJson(ICConnectResponse instance) =>
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

ICWalletAddressResponse _$ICWalletAddressResponseFromJson(
        Map<String, dynamic> json) =>
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

ICTransferRequest _$ICTransferRequestFromJson(Map<String, dynamic> json) =>
    ICTransferRequest(
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

ICTransferResponse _$ICTransferResponseFromJson(Map<String, dynamic> json) =>
    ICTransferResponse(
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

ICTransferToken _$ICTransferTokenFromJson(Map<String, dynamic> json) =>
    ICTransferToken(
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

ICTransferNFT _$ICTransferNFTFromJson(Map<String, dynamic> json) =>
    ICTransferNFT(
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
