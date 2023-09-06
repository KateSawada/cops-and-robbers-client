import 'dart:convert';
import 'package:http/http.dart' as http;

// singleton
class RequestManager {
  // singletonで実装されている.
  // 任意のファイルでこのファイルをimportすると，
  // `RequestManager().get("users", {"name": "Alice"});` のように呼び出せる．
  // ↑`RequestManager()`のように，末尾にカッコが必要なので注意
  static final RequestManager _cache = RequestManager._internal();
  factory RequestManager() {
    return _cache;
  }
  RequestManager._internal();
  // end singleton definition

  String _serverAddress = "";

  set serverAddress(String serverAddress) {
    // TODO: アドレスが正しいかバリデーション
    // TODO: 末尾にスラッシュがついていたら削除
    _serverAddress = serverAddress;
  }

  Future<http.Response> post(String path, Map content) async {
    String body = json.encode(content);
    Map<String, String> headers = {
      'content-type': 'application/json',
    };
    http.Response resp = await http.post(Uri.parse("$_serverAddress/$path"),
        headers: headers, body: body);
    return resp;
  }

  Future<http.Response> _get(
      String path, Map<String, String> parameters) async {
    String queryString = Uri(queryParameters: parameters).query;
    Map<String, String> headers = {
      'content-type': 'application/json',
    };
    http.Response resp = await http.get(
      Uri.parse("$_serverAddress/$path?$queryString"),
      headers: headers,
    );
    return resp;
  }

  Future<List<dynamic>> getList(
      String path, Map<String, String> parameters) async {
    // 最初の階層がList形式のAPIを呼び出す．
    http.Response resp = await _get(path, parameters);
    String jsonArray = utf8.decode(resp.bodyBytes);
    List<dynamic> contents = jsonDecode(jsonArray);
    return contents;
  }

  Future<Map<dynamic, dynamic>> _getMap(
      String path, Map<String, String> parameters) async {
    // 最初の階層がMap形式のAPIを呼び出す．
    http.Response resp = await _get(path, parameters);
    String jsonArray = utf8.decode(resp.bodyBytes);
    Map<dynamic, dynamic> contents = jsonDecode(jsonArray);
    return contents;
  }
}
