import 'package:convert/convert.dart' show hex;
import 'package:walletconnect_dart/src/providers/providers.dart';
import 'package:walletconnect_dart/src/utils/cbor.dart';
import 'package:walletconnect_dart/src/walletconnect.dart';

import 'ic/models.dart';

const ic_method_prefix = 'ic';

extension _ICPrefix on String {
  String ic() => '${ic_method_prefix}_${this}';
}

abstract class ICWallet {
  Future connect({
    required List<String> delegationTargets,
    required String host,
    bool noUnify = false,
  });

  Future<Address> address();

  Future transfer(TransferRequest req);
}

class ICWalletConnectProvider extends WalletConnectProvider
    implements ICWallet {
  ICWalletConnectProvider({
    required WalletConnect connector,
    required this.chainId,
  }) : super(connector: connector);

  @override
  final int chainId;

  @override
  Future connect({
    required List<String> delegationTargets,
    required String host,
    bool noUnify = false,
  }) async {
    final req = {
      'delegationTargets': delegationTargets,
      'host': host,
      'noUnify': noUnify,
    };
    return _wrapRequest('connect', params: req);
  }

  @override
  Future<Address> address() {
    return _wrapRequest('address', factory: Address.fromJson);
  }

  @override
  Future transfer(TransferRequest req) {
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
