import 'package:json_annotation/json_annotation.dart';

part 'json_rpc_request.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class JsonRpcRequest {
  @JsonKey(fromJson: fromId)
  final int id;
  @JsonKey(name: 'jsonrpc')
  final String rpc;
  final String method;
  final List<dynamic>? params;

  JsonRpcRequest({
    required this.id,
    required this.method,
    this.params,
    this.rpc = '2.0',
  });

  factory JsonRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcRequestFromJson(json);

  Map<String, dynamic> toJson() => _$JsonRpcRequestToJson(this);

  @override
  String toString() {
    return 'JsonRpcRequest(id: $id, rpc: $rpc, method: $method, params: $params)';
  }
}

int fromId(dynamic id) {
  return id is int ? id : int.parse(id.toString());
}
