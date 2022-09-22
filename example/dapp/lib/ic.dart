import 'package:walletconnect_dart/walletconnect_dart.dart';

Future<void> main() async {
  final connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
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
    onConnect: (status) async {
      final provider =
          ICWalletConnectProvider(connector: connector, chainId: 10086);
    },
    onSessionUpdate: (response) {
      print("onSessionUpdate: $response");
    },
    onDisconnect: () {
      print('onDisconnect');
    },
  );

  connector.on('call_request', (payload) async {
    print(payload);
  });

  final session = await connector.createSession(
    chainId: 10086,
    onDisplayUri: print,
  );
}
