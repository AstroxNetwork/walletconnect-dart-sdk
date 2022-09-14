import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class ICConnectedPayload {
  final ICDelegationChain delegationChain;
  final ICWalletAddress wallet;

  ICConnectedPayload(this.delegationChain, this.wallet);

  Map<String, dynamic> toJson() => _$ICConnectedPayloadToJson(this);

  factory ICConnectedPayload.fromJson(Map<String, dynamic> json) =>
      _$ICConnectedPayloadFromJson(json);

  @override
  String toString() {
    return 'ICConnectedPayload(delegationChain: $delegationChain, wallet: $wallet)';
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
  final String expiration;
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
class ICWalletAddress {
  final String principal;
  final String accountId;

  ICWalletAddress({
    required this.principal,
    required this.accountId,
  });

  Map<String, dynamic> toJson() => _$ICWalletAddressToJson(this);

  factory ICWalletAddress.fromJson(Map<String, dynamic> json) =>
      _$ICWalletAddressFromJson(json);

  @override
  String toString() {
    return 'ICWalletAddress(principal: $principal, accountId: $accountId)';
  }
}

@JsonSerializable()
class ICTransferRequest {
  ICTransferRequest({
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
      to: to,
      amount: amount!,
      symbol: symbol!,
      standard: standard,
    );
  }

  ICTransferNFT transferNFT() {
    assert(isNFT);
    return ICTransferNFT(
      to: to,
      standard: standard,
      canisterId: canisterId!,
      tokenIndex: tokenIndex!,
      tokenIdentifier: tokenIdentifier!,
    );
  }

  @override
  String toString() {
    return 'ICTransferRequest(to: $to, amount: $amount, symbol: $symbol, standard: $standard, canisterId: $canisterId, tokenIndex: $tokenIndex, tokenIdentifier: $tokenIdentifier)';
  }
}

class ICTransferToken {
  ICTransferToken({
    required this.to,
    required this.amount,
    required this.symbol,
    required this.standard,
  });

  final String to;
  final BigInt amount;
  final String symbol;
  final String standard;

  @override
  String toString() {
    return 'ICTransferToken(to: $to, amount: $amount, symbol: $symbol, standard: $standard)';
  }
}

class ICTransferNFT {
  ICTransferNFT({
    required this.to,
    required this.standard,
    required this.canisterId,
    required this.tokenIndex,
    required this.tokenIdentifier,
  });

  final String to;
  final String standard;
  final String canisterId;
  final int tokenIndex;
  final String tokenIdentifier;

  @override
  String toString() {
    return 'ICTransferNFT(to: $to, standard: $standard, canisterId: $canisterId, tokenIndex: $tokenIndex, tokenIdentifier: $tokenIdentifier)';
  }
}
