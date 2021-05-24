import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;

final loc = window.location;
final path = '${loc.protocol}//${loc.hostname}';

enum FetchMethod {
  get,
  post,
}

Future<String> fetch(
  String url,
  { FetchMethod method = FetchMethod.get, Map<String, dynamic> body, }
) async {
  
  final resp = await HttpRequest.request(
    '$path$url',
    method: method == FetchMethod.get ? 'GET' : 'POST',
    withCredentials: true,
    sendData: body != null ? json.encode(body) : null,
    requestHeaders: {
      if (body != null) 'Content-Type': 'application/json'
    }
  );

  if (resp.status == 401) { // unauthorized
    var encoded = Uri.encodeFull(window.location.href.toString());
    window.location.href = '/login?from=$encoded';
    return null;
  }

  print(resp.response);
  return '';

}