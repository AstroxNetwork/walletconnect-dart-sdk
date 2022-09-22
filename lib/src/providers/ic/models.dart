import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class ICConnectRequest {
  ICConnectRequest({
    required this.accountId,
    required this.publicKey,
    required this.delegationTargets,
    required this.host,
    this.noUnify = false,
  });

  Map<String, dynamic> toJson() => _$ICConnectRequestToJson(this);

  factory ICConnectRequest.fromJson(Map<String, dynamic> json) =>
      _$ICConnectRequestFromJson(json);

  // hex string
  final String publicKey;

  // canister ids
  final List<String> delegationTargets;

  // uri origin
  final String host;
  final bool noUnify;
  final String accountId;

  @override
  String toString() {
    return 'ICConnectRequest(publicKey: $publicKey, delegationTargets: $delegationTargets, host: $host, noUnify: $noUnify, accountId: $accountId)';
  }
}

@JsonSerializable()
class ICConnectResponse {
  final ICDelegationChain delegationChain;
  final ICWalletAddressResponse wallet;

  ICConnectResponse({
    required this.delegationChain,
    required this.wallet,
  });

  Map<String, dynamic> toJson() => _$ICConnectResponseToJson(this);

  factory ICConnectResponse.fromJson(Map<String, dynamic> json) =>
      _$ICConnectResponseFromJson(json);

  @override
  String toString() {
    return 'ICConnectResponse(delegationChain: $delegationChain, wallet: $wallet)';
  }
}

@JsonSerializable()
class ICDelegationChain {
  final String publicKey;
  final List<ICSignedDelegation> delegations;

  ICDelegationChain({
    required this.publicKey,
    required this.delegations,
  });

  Map<String, dynamic> toJson() => _$ICDelegationChainToJson(this);

  factory ICDelegationChain.fromJson(Map<String, dynamic> json) =>
      _$ICDelegationChainFromJson(json);

  @override
  String toString() {
    return 'ICDelegationChain(publicKey: $publicKey, delegations: $delegations)';
  }
}

@JsonSerializable()
class ICSignedDelegation {
  final String? signature;
  final ICDelegation? delegation;

  ICSignedDelegation({
    this.signature,
    this.delegation,
  });

  Map<String, dynamic> toJson() => _$ICSignedDelegationToJson(this);

  factory ICSignedDelegation.fromJson(Map<String, dynamic> json) =>
      _$ICSignedDelegationFromJson(json);

  @override
  String toString() {
    return 'ICSignedDelegation(signature: $signature, delegation: $delegation)';
  }
}

@JsonSerializable()
class ICDelegation {
  final BigInt expiration;
  @JsonKey(name: 'pubkey')
  final String publicKey;
  final List<String>? targets;

  ICDelegation({
    required this.expiration,
    required this.publicKey,
    this.targets,
  });

  Map<String, dynamic> toJson() => _$ICDelegationToJson(this);

  factory ICDelegation.fromJson(Map<String, dynamic> json) =>
      _$ICDelegationFromJson(json);

  @override
  String toString() {
    return 'ICDelegation(expiration: $expiration, pubkey: $publicKey, targets: $targets)';
  }
}

@JsonSerializable()
class ICWalletAddressResponse {
  final String principal;
  final String accountId;

  ICWalletAddressResponse({
    required this.principal,
    required this.accountId,
  });

  Map<String, dynamic> toJson() => _$ICWalletAddressResponseToJson(this);

  factory ICWalletAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$ICWalletAddressResponseFromJson(json);

  @override
  String toString() {
    return 'ICWalletAddress(principal: $principal, accountId: $accountId)';
  }
}

@JsonSerializable()
class ICTransferRequest {
  ICTransferRequest({
    required this.from,
    required this.to,
    required this.standard,
    this.amount,
    this.symbol,
    this.canisterId,
    this.tokenIndex,
    this.tokenIdentifier,
  });

  Map<String, dynamic> toJson() => _$ICTransferRequestToJson(this);

  factory ICTransferRequest.fromJson(Map<String, dynamic> json) =>
      _$ICTransferRequestFromJson(json);

  final String from;
  final String to;
  final BigInt? amount;

  final String? symbol;
  final String standard;
  final String? canisterId;
  final int? tokenIndex;
  final String? tokenIdentifier;

  bool get isToken => amount != null;

  bool get isNFT =>
      canisterId != null && tokenIndex != null && tokenIdentifier != null;

  ICTransferToken transferToken() {
    assert(isToken);
    return ICTransferToken(
      from: from,
      to: to,
      amount: amount!,
      symbol: symbol!,
      standard: standard,
    );
  }

  ICTransferNFT transferNFT() {
    assert(isNFT);
    return ICTransferNFT(
      from: from,
      to: to,
      standard: standard,
      canisterId: canisterId!,
      tokenIndex: tokenIndex!,
      tokenIdentifier: tokenIdentifier!,
    );
  }

  @override
  String toString() {
    return 'ICTransferRequest(from: $from, to: $to, amount: $amount, symbol: $symbol, standard: $standard, canisterId: $canisterId, tokenIndex: $tokenIndex, tokenIdentifier: $tokenIdentifier)';
  }
}

@JsonSerializable()
class ICTransferResponse {
  ICTransferResponse({
    this.blockHeight,
    required this.amount,
    this.transactionId,
  });

  Map<String, dynamic> toJson() => _$ICTransferResponseToJson(this);

  factory ICTransferResponse.fromJson(Map<String, dynamic> json) =>
      _$ICTransferResponseFromJson(json);

  final BigInt? blockHeight;
  final String amount;
  final String? transactionId;

  @override
  String toString() {
    return 'ICTransferResponse(blockHeight: $blockHeight, amount: $amount, transactionId: $transactionId)';
  }
}

@JsonSerializable()
class ICTransferToken {
  ICTransferToken({
    required this.from,
    required this.to,
    required this.amount,
    required this.symbol,
    required this.standard,
  });

  final String from;
  final String to;
  final BigInt amount;
  final String symbol;
  final String standard;

  Map<String, dynamic> toJson() => _$ICTransferTokenToJson(this);

  factory ICTransferToken.fromJson(Map<String, dynamic> json) =>
      _$ICTransferTokenFromJson(json);

  @override
  String toString() {
    return 'ICTransferToken(from: $from, to: $to, amount: $amount, symbol: $symbol, standard: $standard)';
  }
}

@JsonSerializable()
class ICTransferNFT {
  ICTransferNFT({
    required this.from,
    required this.to,
    required this.standard,
    required this.canisterId,
    required this.tokenIndex,
    required this.tokenIdentifier,
  });

  final String from;
  final String to;
  final String standard;
  final String canisterId;
  final int tokenIndex;
  final String tokenIdentifier;

  Map<String, dynamic> toJson() => _$ICTransferNFTToJson(this);

  factory ICTransferNFT.fromJson(Map<String, dynamic> json) =>
      _$ICTransferNFTFromJson(json);

  @override
  String toString() {
    return 'ICTransferNFT(from: $from, to: $to, standard: $standard, canisterId: $canisterId, tokenIndex: $tokenIndex, tokenIdentifier: $tokenIdentifier)';
  }
}
