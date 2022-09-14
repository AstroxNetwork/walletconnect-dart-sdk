import 'package:convert/convert.dart' show hex;
import 'package:walletconnect_dart/src/providers/providers.dart';
import 'package:walletconnect_dart/src/utils/cbor.dart';
import 'package:walletconnect_dart/src/walletconnect.dart';

import 'ic/models.dart';

const ic_method_prefix = 'ic';

extension _ICPrefix on String {
  String ic() => '${ic_method_prefix}_${this}';
}

abstract class ICWalletConnector {
  Future<ICConnectedPayload> connect({
    // hex string
    required String publicKey,
    // canister ids
    required List<String> delegationTargets,
    // uri origin
    required String host,
    bool noUnify = false,
  });

  Future<ICWalletAddress> address();

  Future transfer(ICTransferRequest req);
}

class ICWalletConnectProvider extends WalletConnectProvider
    implements ICWalletConnector {
  ICWalletConnectProvider({
    required WalletConnect connector,
    required this.chainId,
  }) : super(connector: connector);

  @override
  final int chainId;

  @override
  Future<ICConnectedPayload> connect({
    required String publicKey,
    required List<String> delegationTargets,
    required String host,
    bool noUnify = false,
  }) async {
    final req = {
      'publicKey': publicKey,
      'delegationTargets': delegationTargets,
      'host': host,
      'noUnify': noUnify,
    };
    return _wrapRequest(
      'connect',
      params: req,
      factory: ICConnectedPayload.fromJson,
    );
  }

  @override
  Future<ICWalletAddress> address() {
    return _wrapRequest('address', factory: ICWalletAddress.fromJson);
  }

  @override
  Future transfer(ICTransferRequest req) {
    return _wrapRequest(
      'transfer',
      params: req.toJson(),
    );
  }

  Future<T> _wrapRequest<T>(
    String method, {
    dynamic params,
    ObjectFactory<T>? factory,
  }) async {
    final rawParams = [if (params != null) hex.encode(cborEncode(params))];
    print('$method req: $rawParams');
    final rep = await connector.sendCustomRequest(
      method: method.ic(),
      params: rawParams,
    );
    final decode = cborDecode<T>(hex.decode(rep), factory: factory);
    print('$method rep: $decode');
    return decode;
  }
}
