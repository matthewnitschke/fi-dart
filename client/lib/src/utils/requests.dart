import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;

final loc = window.location;
final path = '${loc.protocol}//${loc.hostname}';

enum FetchMethod {
  get,
  post,
}

Future<http.Response> fetch(
  String url,
  { Map<String, dynamic> body, }
) async {

  final resp = await http.post(
    '$path$url',
    body: body != null ? json.encode(body) : null,
    headers: {
      if (body != null) 'Content-Type': 'application/json'
    }
  );

  if (resp.statusCode == 401) { // unauthorized
    var encoded = Uri.encodeFull(window.location.href.toString());
    window.location.href = '/login?from=$encoded';
    return null;
  }

  return resp;
}