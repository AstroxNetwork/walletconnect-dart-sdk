import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:walletconnect_dart/src/exceptions/exceptions.dart';
import 'package:walletconnect_dart/src/session/peer_meta.dart';
import 'package:walletconnect_dart/src/utils/json_converters.dart';

part 'wallet_connect_session.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class WalletConnectSession {
  String protocol;
  int version;
  bool connected;
  List<String> accounts;
  int chainId;
  String bridge = '';

  @KeyConverter()
  Uint8List? key;
  String clientId = '';
  PeerMeta? clientMeta;
  String peerId = '';
  PeerMeta? peerMeta;
  int handshakeId = 0;
  String handshakeTopic = '';
  int networkId = 0;
  String rpcUrl = '';

  WalletConnectSession({
    required this.accounts,
    this.protocol = 'wc',
    this.version = 1,
    this.connected = false,
    this.chainId = 0,
    this.bridge = '',
    this.key,
    this.clientId = '',
    this.clientMeta,
    this.peerId = '',
    this.peerMeta,
    this.handshakeId = 0,
    this.handshakeTopic = '',
    this.networkId = 0,
    this.rpcUrl = '',
  });

  factory WalletConnectSession.fromUri({
    required String uri,
    String? clientId,
    PeerMeta? clientMeta,
    List<String>? accounts,
  }) {
    clientId ??= const Uuid().v4();
    clientMeta ??= const PeerMeta();
    final protocolSeparator = uri.indexOf(':');
    final topicSeparator = uri.indexOf('@', protocolSeparator);
    final versionSeparator = uri.indexOf('?');
    final protocol = uri.substring(0, protocolSeparator);
    final handshakeTopic = uri.substring(protocolSeparator + 1, topicSeparator);

    final version = uri.substring(topicSeparator + 1, versionSeparator);
    final params = Uri.dataFromString(uri).queryParameters;
    final bridge = params['bridge'] ??
        (throw WalletConnectException('Missing bridge param in URI'));

    final key = params['key'] ??
        (throw WalletConnectException('Missing key param in URI'));

    return WalletConnectSession(
      protocol: protocol,
      version: int.tryParse(version) ?? 1,
      handshakeTopic: handshakeTopic,
      bridge: Uri.decodeFull(bridge),
      key: Uint8List.fromList(hex.decode(key)),
      accounts: accounts ?? [],
      clientId: clientId,
      clientMeta: clientMeta,
    );
  }

  /// Approve the session.
  void approve(Map<String, dynamic> params) {
    connected = true;
    chainId = params['chainId'] ?? chainId;
    accounts = params['accounts']?.cast<String>() ?? accounts;
    peerId = params['peerId'] ?? peerId;
    peerMeta = params.containsKey('peerMeta')
        ? PeerMeta.fromJson(params['peerMeta'])
        : peerMeta;
  }

  /// Reset the session.
  void reset() {
    connected = false;
    accounts = [];
    handshakeId = 0;
    handshakeTopic = '';
  }

  /// Get the display uri.
  String toUri() {
    return '$protocol:$handshakeTopic@$version?bridge=${Uri.encodeComponent(bridge)}&key=${hex.encode(key ?? [])}';
  }

  factory WalletConnectSession.fromJson(Map<String, dynamic> json) =>
      _$WalletConnectSessionFromJson(json);

  Map<String, dynamic> toJson() => _$WalletConnectSessionToJson(this);

  @override
  String toString() {
    return 'WalletConnectSession(protocol: $protocol, version: $version, connected: $connected, accounts: $accounts, chainId: $chainId, bridge: $bridge, key: $key, clientId: $clientId, clientMeta: $clientMeta, peerId: $peerId, peerMeta: $peerMeta, handshakeId: $handshakeId, handshakeTopic: $handshakeTopic, networkId: $networkId, rpcUrl: $rpcUrl)';
  }
}
