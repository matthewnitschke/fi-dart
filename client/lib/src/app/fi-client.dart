import 'dart:html';

import 'package:http/http.dart' as http;
class FiClient {
  Uri _getUrl(String suffix) {
    final loc = window.location;
    // final port = 3000;
    return Uri.parse('${loc.protocol}//${loc.hostname}$suffix');
  }

  void testCall() async {
    var response = await http.post(_getUrl('/transactions'), body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

  }
}