// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_session_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WCSessionRequestResponse _$WCSessionRequestResponseFromJson(Map json) =>
    WCSessionRequestResponse(
      approved: json['approved'] as bool? ?? false,
      chainId: json['chainId'] as int?,
      accounts: (json['accounts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      peerId: json['peerId'] as String?,
      peerMeta: json['peerMeta'] == null
          ? null
          : PeerMeta.fromJson(
              Map<String, dynamic>.from(json['peerMeta'] as Map)),
    );

Map<String, dynamic> _$WCSessionRequestResponseToJson(
        WCSessionRequestResponse instance) =>
    <String, dynamic>{
      'approved': instance.approved,
      'chainId': instance.chainId,
      'accounts': instance.accounts,
      'peerId': instance.peerId,
      'peerMeta': instance.peerMeta?.toJson(),
    };
