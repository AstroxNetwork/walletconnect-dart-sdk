import 'dart:ui';

// import 'package:agent_dart/agent_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dapp/algorand_transaction_tester.dart';
import 'package:mobile_dapp/ethereum_transaction_tester.dart';
import 'package:mobile_dapp/transaction_tester.dart';
import 'package:mobile_dapp/wallet_connect_lifecycle.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

void main() {
  runApp(const MyApp());
}

enum NetworkType {
  ethereum,
  algorand,
}

enum TransactionState {
  disconnected,
  connecting,
  connected,
  connectionFailed,
  transferring,
  success,
  failed,
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile dApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (_) => const MyHomePage(title: 'WalletConnect'),
        "/ic": (_) => IC(),
      },
    );
  }
}

class NewValueNotifier<T> extends ChangeNotifier implements ValueListenable<T> {
  NewValueNotifier(this._value);

  @override
  T get value => _value;
  T _value;

  set value(T value) {
    newValue(value, false);
  }

  void newValue(T newValue, [bool forceUpdate = true]) {
    if (_value == newValue && !forceUpdate) {
      return;
    }
    _value = newValue;
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}

class IC extends StatefulWidget {
  const IC({Key? key}) : super(key: key);

  @override
  State<IC> createState() => _ICState();
}

class _ICState extends State<IC> {
  final NewValueNotifier<List<String>> _logs = NewValueNotifier([]);

  String? _accountId;

  late final _connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: PeerMeta(
      name: 'WalletConnect',
      description: 'WalletConnect Developer App',
      url: 'https://walletconnect.org',
      icons: [
        'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
      ],
    ),
  )..registerListeners(
      onDisconnect: () {
        log("onDisconnect");
      },
      onSessionUpdate: (resp) {
        log("onSessionUpdate: $resp");
      },
      onConnect: (status) {
        log("onConnect: $status");
        _accountId = status.accounts.first;
        Navigator.popUntil(context, (route) => route.settings.name == '/ic');
      },
      onCallRequest: (request) {
        log("onCallRequest: $request");
      },
    );

  late final _provider = ICWalletConnectProvider(
    connector: _connector,
    chainId: 10086,
  );

  void log(dynamic log) {
    final str = "${DateTime.now()}: $log";
    print(str);
    _logs.value.insert(0, str);
    _logs.newValue(_logs.value);
  }

  @override
  Widget build(BuildContext context) {
    return WalletConnectLifecycle(
      connector: _connector,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQueryData.fromWindow(window).padding.top,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        log("createSession");
                        _connector.createSession(
                          chainId: 10086,
                          onDisplayUri: (uri) {
                            log("onDisplayUri: $uri");
                            _showQR(uri);
                          },
                        );
                      },
                      child: Text("request connect"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        log("close");
                        _connector.close();
                      },
                      child: Text("request close"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        log("killSession");
                        _connector.killSession();
                      },
                      child: Text("request killSession"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // final identity =
                        //     await Ed25519KeyIdentity.generate(null);
                        // final hex = identity.getPublicKey().toDer().toHex();
                        // final request = ICConnectRequest(
                        //   accountId: _accountId!,
                        //   publicKey: hex,
                        //   delegationTargets: [
                        //     "l2gs2-tqaaa-aaaai-qcmrq-cai",
                        //     "lpbdx-syaaa-aaaai-qcmsa-cai",
                        //   ],
                        //   host: 'https://bridge.walletconnect.org',
                        // );
                        // log("call connect start: $request");
                        // final response = await _provider.connect(request);
                        // log("call connect end: $response");
                      },
                      child: Text("connect"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        log("call address start: $_accountId");
                        final address = await _provider.address(_accountId!);
                        log("call address end: $address");
                      },
                      child: Text("address"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final request = ICTransferRequest(
                          from: _accountId!,
                          to: "dnt7r-aa7ub-2ptq7-t7oqo-ndhjb-qyk6n-ltd35-e243a-3i7b5-5cez3-vae",
                          standard: "ICP",
                          amount: BigInt.from(10000),
                          symbol: "ICP",
                        );
                        log("call transfer token start: $request");
                        final response = await _provider.transfer(request);
                        log("call transfer token end: $response");
                      },
                      child: Text("transfer token"),
                    ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final request = ICTransferRequest(
                    //       from: _accountId!,
                    //       to: "dnt7r-aa7ub-2ptq7-t7oqo-ndhjb-qyk6n-ltd35-e243a-3i7b5-5cez3-vae",
                    //       standard: "EXT",
                    //     );
                    //     log("call transfer token start: $request");
                    //     final response = await _provider.transfer(request);
                    //     log("call transfer token end: $response");
                    //   },
                    //   child: Text("transfer token"),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue),
                ),
                child: ValueListenableBuilder<List<String>>(
                  valueListenable: _logs,
                  builder: (context, value, _) {
                    return ListView.separated(
                      padding: EdgeInsets.all(16.0),
                      itemBuilder: (_, index) {
                        return SelectableText(
                          value[index],
                          style: TextStyle(fontSize: 12),
                        );
                      },
                      itemCount: value.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQueryData.fromWindow(window).padding.bottom + 24.0,
            ),
          ],
        ),
      ),
    );
  }

  void _showQR(String uri) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          child: QrImageView(
            data: uri,
            size: double.infinity,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String txId = '';
  String _displayUri = '';

  static const _networks = ['Ethereum (Ropsten)', 'Algorand (Testnet)'];
  NetworkType? _network = NetworkType.ethereum;
  TransactionState _state = TransactionState.disconnected;
  TransactionTester? _transactionTester = EthereumTransactionTester();

  @override
  Widget build(BuildContext context) {
    return WalletConnectLifecycle(
      connector: _transactionTester!.connector,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/ic");
              },
              icon: Icon(Icons.next_plan_outlined),
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('Select network: ',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: DropdownButton(
                      value: _networks[_network!.index],
                      items: _networks
                          .map(
                            (value) => DropdownMenuItem(
                                value: value, child: Text(value)),
                          )
                          .toList(),
                      onChanged: _changeNetworks),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_displayUri.isEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: Text(
                            'Click on the button below to transfer ${_network == NetworkType.ethereum ? '0.0001 Eth from Ethereum' : '0.0001 Algo from the Algorand'} account connected through WalletConnect to the same account.',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : QrImageView(data: _displayUri),
                  ElevatedButton(
                    onPressed:
                        _transactionStateToAction(context, state: _state),
                    child: Text(
                      _transactionStateToString(state: _state),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _transactionTester?.disconnect();
                    },
                    child: Text(
                      'Close',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeNetworks(String? network) {
    if (network == null) return null;
    final newNetworkIndex = _networks.indexOf(network);
    final newNetwork = NetworkType.values[newNetworkIndex];

    switch (newNetwork) {
      case NetworkType.algorand:
        _transactionTester = AlgorandTransactionTester();
        break;
      case NetworkType.ethereum:
        _transactionTester = EthereumTransactionTester();
        break;
    }

    setState(
      () => _network = newNetwork,
    );
  }

  String _transactionStateToString({required TransactionState state}) {
    switch (state) {
      case TransactionState.disconnected:
        return 'Connect!';
      case TransactionState.connecting:
        return 'Connecting';
      case TransactionState.connected:
        return 'Session connected, preparing transaction...';
      case TransactionState.connectionFailed:
        return 'Connection failed';
      case TransactionState.transferring:
        return 'Transaction in progress...';
      case TransactionState.success:
        return 'Transaction successful';
      case TransactionState.failed:
        return 'Transaction failed';
    }
  }

  VoidCallback? _transactionStateToAction(BuildContext context,
      {required TransactionState state}) {
    switch (state) {
      // Progress, action disabled
      case TransactionState.connecting:
      case TransactionState.transferring:
      case TransactionState.connected:
        return null;

      // Initiate the connection
      case TransactionState.disconnected:
      case TransactionState.connectionFailed:
        return () async {
          setState(() => _state = TransactionState.connecting);
          final session = await _transactionTester?.connect(
            onDisplayUri: (uri) => setState(() => _displayUri = uri),
          );
          if (session == null) {
            print('Unable to connect');
            setState(() => _state = TransactionState.failed);
            return;
          }

          setState(() => _state = TransactionState.connected);
          Future.delayed(const Duration(seconds: 1), () async {
            // Initiate the transaction
            setState(() => _state = TransactionState.transferring);

            try {
              await _transactionTester?.signTransaction(session);
              setState(() => _state = TransactionState.success);
            } catch (e) {
              print('Transaction error: $e');
              setState(() => _state = TransactionState.failed);
            }
          });
        };

      // Finished
      case TransactionState.success:
      case TransactionState.failed:
        return null;
    }
  }
}
