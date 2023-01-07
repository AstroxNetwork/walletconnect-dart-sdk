// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WCSessionRequest _$WCSessionRequestFromJson(Map json) => WCSessionRequest(
      chainId: json['chainId'] as int?,
      peerId: json['peerId'] as String?,
      peerMeta: json['peerMeta'] == null
          ? null
          : PeerMeta.fromJson(
              Map<String, dynamic>.from(json['peerMeta'] as Map)),
    );

Map<String, dynamic> _$WCSessionRequestToJson(WCSessionRequest instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'peerId': instance.peerId,
      'peerMeta': instance.peerMeta?.toJson(),
    };
