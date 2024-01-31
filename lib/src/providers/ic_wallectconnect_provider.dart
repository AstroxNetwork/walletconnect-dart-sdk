import 'dart:async';

import 'package:convert/convert.dart' show hex;
import 'package:walletconnect_dart/src/api/api.dart';
import 'package:walletconnect_dart/src/providers/providers.dart';
import 'package:walletconnect_dart/src/utils/cbor.dart';
import 'package:walletconnect_dart/src/walletconnect.dart';

const ic_method_prefix = 'ic';

extension _ICPrefix on String {
  String ic() => '${ic_method_prefix}_$this';
}

abstract class ICWalletRequestConnector {
  Future<ICConnectResponse> connect(ICConnectRequest request);

  Future<ICWalletAddressResponse> address(String accountId);

  Future<ICTransferResponse> transfer(ICTransferRequest req);
}

typedef ReplyResponse<Req, Rep> = FutureOr<Rep> Function(Req request);

abstract class ICWalletResponseConnector {
  Future<void> replyAddress(
    JsonRpcRequest request,
    ReplyResponse<String, ICWalletAddressResponse> reply,
  );

  Future<void> replyConnect(
    JsonRpcRequest request,
    ReplyResponse<ICConnectRequest, ICConnectResponse> reply,
  );

  Future<void> replyTransfer(
    JsonRpcRequest request,
    ReplyResponse<ICTransferRequest, ICTransferResponse> reply,
  );
}

class ICWalletConnectProvider extends WalletConnectProvider
    implements ICWalletRequestConnector, ICWalletResponseConnector {
  ICWalletConnectProvider({
    required WalletConnect connector,
    required this.chainId,
  }) : super(connector: connector);

  @override
  final int chainId;

  @override
  Future<ICConnectResponse> connect(ICConnectRequest request) async {
    return _wrapRequest(
      'connect',
      params: request.toJson(),
      factory: ICConnectResponse.fromJson,
    );
  }

  @override
  Future<ICWalletAddressResponse> address(String accountId) {
    return _wrapRequest(
      'address',
      params: accountId,
      factory: ICWalletAddressResponse.fromJson,
    );
  }

  @override
  Future<ICTransferResponse> transfer(ICTransferRequest req) {
    return _wrapRequest(
      'transfer',
      params: req.toJson(),
    );
  }

  @override
  Future<void> replyAddress(
    JsonRpcRequest request,
    ReplyResponse<String, ICWalletAddressResponse> reply,
  ) async {
    try {
      final decoded = _decodeRequestParam<String>(request);
      final resp = await reply(decoded);
      return _wrapResponse(request.id, response: resp.toJson());
    } catch (e) {
      return _wrapResponse(request.id, error: e.toString());
    }
  }

  @override
  Future<void> replyConnect(
    JsonRpcRequest request,
    ReplyResponse<ICConnectRequest, ICConnectResponse> reply,
  ) async {
    try {
      final decoded = _decodeRequestParam<ICConnectRequest>(
        request,
        ICConnectRequest.fromJson,
      );
      final resp = await reply(decoded);
      return _wrapResponse(request.id, response: resp.toJson());
    } catch (e) {
      return _wrapResponse(request.id, error: e.toString());
    }
  }

  @override
  Future<void> replyTransfer(
    JsonRpcRequest request,
    ReplyResponse<ICTransferRequest, ICTransferResponse> reply,
  ) async {
    try {
      final decoded = _decodeRequestParam<ICTransferRequest>(
        request,
        ICTransferRequest.fromJson,
      );
      final resp = await reply(decoded);
      return _wrapResponse(request.id, response: resp.toJson());
    } catch (e) {
      return _wrapResponse(request.id, error: e.toString());
    }
  }

  T _decodeRequestParam<T>(
    JsonRpcRequest request, [
    ObjectFactory<T>? factory,
  ]) {
    final params = request.params;
    if (params == null || params.isEmpty) {
      throw ArgumentError();
    }
    final encoded = params.first;
    return cborDecode<T>(
      hex.decode(encoded),
      factory: factory,
    );
  }

  Future<T> _wrapRequest<T>(
    String method, {
    dynamic params,
    ObjectFactory<T>? factory,
  }) async {
    final rawParams = [if (params != null) hex.encode(cborEncode(params))];
    final rep = await connector.sendCustomRequest(
      method: method.ic(),
      params: rawParams,
    );
    return cborDecode<T>(hex.decode(rep), factory: factory);
  }

  Future<void> _wrapResponse<T>(
    int id, {
    T? response,
    String? error,
  }) async {
    await connector.sendCustomResponse(
      id: id,
      result: response == null ? null : hex.encode(cborEncode(response)),
      error: error,
    );
  }
}
