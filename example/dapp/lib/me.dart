import 'package:agent_dart/agent_dart.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

Future<void> main() async {
  final uri =
      "wc:9dfc1c48-c54f-42a4-86dc-55388c123170@1?bridge=https%3A%2F%2Fc.bridge.walletconnect.org&key=86fb9a9b8755675e95664c0c1c8593434aeea12d184f148d78889e7499ea9414";
  final connector = WalletConnect(
    uri: uri,
    clientMeta: PeerMeta(
      name: 'WalletConnect',
      description: 'WalletConnect Developer App',
      url: 'https://walletconnect.org',
      icons: [
        'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
      ],
    ),
  );
  connector.registerListeners(
    onConnect: (status) {
      print("me onConnect: $status");
    },
    onSessionUpdate: (response) {
      print("me onSessionUpdate: $response");
    },
    onDisconnect: () {
      print('me onDisconnect');
    },
  );
  connector.on('session_request', (payload) async {
    print(payload);
    await connector.approveSession(
      accounts: ["123456"],
      chainId: 10086,
    );
  });
  final provider =
      ICWalletConnectProvider(connector: connector, chainId: 10086);
  connector.on<JsonRpcRequest>('call_request', (request) async {
    final method = request.method;
    if (method == 'ic_address') {
      await provider.replyAddress(request, (request) async {
        return ICWalletAddressResponse(principal: "123456", accountId: request);
      });
    } else if (method == 'ic_connect') {
      // await provider.replyConnect(request, (request) async {
      //   return ICConnectResponse(
      //     wallet: ICWalletAddressResponse(
      //       principal: "123456",
      //       accountId: "123456",
      //     ),
      //   );
      // });
    }
  });

  connector.on('ic_address', (payload) async {
    print(payload);
  });
  // final status = await connector.connect();
  // print(status);
  // await connector.approveSession(
  //   accounts: status.accounts,
  //   chainId: status.chainId,
  // );
}
