import 'dart:convert';
import 'dart:html';

import 'package:built_collection/built_collection.dart';
import 'package:fi/src/app/models/transaction.sg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final _dateFormat = DateFormat('y-MM-dd');

class FiClient {
  static Uri _getUrl(String suffix) {
    final loc = window.location;
    // final port = 3000;
    return Uri.parse('${loc.protocol}//${loc.hostname}$suffix');
  }

  void testCall() async {
    var response = await http.post(_getUrl('/transactions'), body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  static Future<BuiltMap<String, Transaction>> getTransactions(
    DateTime from,
    DateTime to,
  ) async {
    final resp = await http.get(_getUrl('/transactions?from=${_dateFormat.format(from)}&to=${_dateFormat.format(to)}'));
    // final resp = await http.get(_getUrl('/transactions?from=2021-01-01&to=2021-02-01'));
    
    final encodedTransactions = json.decode(resp.body) as List<dynamic>;

    return BuiltMap<String, Transaction>(
      Map.fromEntries(
        encodedTransactions.map((encodedTransaction) {
          // var name = encodedTransaction['merchant'] as String;
          // name = name.replaceAll(RegExp('\d'), '');

          return MapEntry(
            encodedTransaction['_id'] as String,
            Transaction((b) => b
              ..amount = (encodedTransaction['amount'] as double) * -1
              ..merchant = encodedTransaction['merchant'] as String
              ..date = DateTime.parse(encodedTransaction['date'] as String)
            ),
          );
        })
      )
    );
  }
}