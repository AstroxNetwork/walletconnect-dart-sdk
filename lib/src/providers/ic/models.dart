import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class Address {
  final String principal;
  final String accountId;

  Address({
    required this.principal,
    required this.accountId,
  });

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  @override
  String toString() {
    return 'Address(principal: $principal, accountId: $accountId)';
  }
}

@JsonSerializable()
class TransferRequest {
  TransferRequest({
    required this.to,
    required this.standard,
    this.amount,
    this.symbol,
    this.canisterId,
    this.tokenIndex,
    this.tokenIdentifier,
  });

  Map<String, dynamic> toJson() => _$TransferRequestToJson(this);

  factory TransferRequest.fromJson(Map<String, dynamic> json) =>
      _$TransferRequestFromJson(json);

  final String to;
  final BigInt? amount;

  final String? symbol;
  final String standard;
  final String? canisterId;
  final int? tokenIndex;
  final String? tokenIdentifier;

  bool get isToken => amount != null;

  bool get isNFT => canisterId != null && tokenIndex != null;

  TransferToken transferToken() {
    assert(isToken);
    return TransferToken(
      to: to,
      amount: amount!,
      symbol: symbol!,
      standard: standard,
    );
  }

  TransferNFT transferNFT() {
    assert(isNFT);
    return TransferNFT(
      to: to,
      standard: standard,
      canisterId: canisterId!,
      tokenIndex: tokenIndex!,
      tokenIdentifier: tokenIdentifier!,
    );
  }

  @override
  String toString() {
    return 'TransferRequest(to: $to, amount: $amount, symbol: $symbol, standard: $standard, canisterId: $canisterId, tokenIndex: $tokenIndex, tokenIdentifier: $tokenIdentifier)';
  }
}

class TransferToken {
  TransferToken({
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
    return 'TransferNFT(to: $to, amount: $amount, symbol: $symbol, standard: $standard)';
  }
}

class TransferNFT {
  TransferNFT({
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
    return 'TransferToken(to: $to, standard: $standard, canisterId: $canisterId, tokenIndex: $tokenIndex, tokenIdentifier: $tokenIdentifier)';
  }
}
