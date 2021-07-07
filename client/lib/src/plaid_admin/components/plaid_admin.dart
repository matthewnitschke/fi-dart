import 'dart:convert';

import 'package:fi/src/models/account.sg.dart';
import 'package:fi/src/models/serializers.sg.dart';
import 'package:fi/src/utils/requests.dart';
import 'package:over_react/over_react.dart';

part 'plaid_admin.over_react.g.dart';

mixin PlaidAdminProps on UiProps {}

UiFactory<PlaidAdminProps> PlaidAdmin = uiFunction(
  (props) {
    final accounts = useState<List<Account>>([]);
    useEffect(() {
      fetch('/plaid-admin/accounts').then((r) {
        final accountsJson = json.decode(r.body) as List<dynamic>;
        final data = accountsJson.map((accountJson) => serializers.deserializeWith(Account.serializer, accountJson)).toList();
        accounts.set(data);
      });
    }, []);

    final env = useState("");
    useEffect(() {
      fetch('/plaid-admin/env').then((r) {
        final resp = json.decode(r.body) as Map<String, dynamic>;
        env.set(resp['env']);
      });
    });

    return (Dom.div()
      ..style = { 'maxWidth': '50rem', 'margin': 'auto' }
    )(
      Dom.h1()('Accounts'),
      Dom.div()('Plaid Env: "${env.value}"'),

      accounts.value.map((account) {
        return (Dom.div()
          ..key = account.email
        )(
          Dom.h2()(account.email),

          (Dom.div()
            ..style = {'paddingLeft': '1rem', 'borderLeft': 'solid 4px lightblue'}
          )(
            Dom.h3()('Access Token'),
            (Dom.input()
              ..style = { 'width': '30rem' }
              ..defaultValue = account.plaidAccessToken
              ..onBlur = ((event) {
                fetch('/plaid-admin/set-user-access-token', body: {
                  'email': account.email,
                  'plaidAccessToken': event.target.value.toString()
                });
              })
            )(),

            (TestConnectionButton()..email = account.email)(),

            (SyncTransactionsInput()..email = account.email)(),
          )
        );
      }),
    );
  },
  _$PlaidAdminConfig, // ignore: undefined_identifier
);



mixin TestConnectionButtonProps on UiProps {
  String email;
}

UiFactory<TestConnectionButtonProps> TestConnectionButton = uiFunction(
  (props) {
    final isSuccess = useState<bool>(null);

    var buttonText = 'Test';
    if (isSuccess.value != null) {
      buttonText = isSuccess.value ? 'Success' : 'Failure';
    }

    return (Dom.button()
      ..onClick = ((_) {
        fetch('/plaid-admin/test-connection', body: {'email': props.email})
          .then((resp) {
            isSuccess.set(resp.statusCode < 300);

            if (resp.statusCode >= 300) {
              print('-------- Plaid Test Connection Failure --------');
              final encoder = new JsonEncoder.withIndent('  ');
              print(encoder.convert(json.decode(resp.body)));
            }
          });
      })
    )(
      buttonText
    );
  },
  _$TestConnectionButtonConfig, // ignore: undefined_identifier
);



mixin SyncTransactionsInputProps on UiProps {
  String email;
}

UiFactory<SyncTransactionsInputProps> SyncTransactionsInput = uiFunction(
  (props) {
    final from = useState("");
    final to = useState("");

    final isSuccess = useState<bool>(null);

    return Dom.div()(
      Dom.h3()('Sync Transactions'),
      (Dom.input()
        ..placeholder = 'from (yyyy-mm-dd)'
        ..value = from.value
        ..onChange = ((e) => from.set(e.target.value as String))
      )(),
      (Dom.input()
        ..placeholder = 'to (yyyy-mm-dd)'
        ..value = to.value
        ..onChange = ((e) => to.set(e.target.value as String))
      )(),

      (Dom.button()
        ..onClick = ((_) {
          fetch(
            '/plaid-admin/syncTransactions', 
            body: {
              'email': props.email,
              'from': from.value,
              'to': to.value,
            }
          ).then((resp) {
            isSuccess.set(resp.statusCode < 300);

            if (resp.statusCode >= 300) {
              print('-------- Plaid SyncTransactions Failure --------');
              final encoder = new JsonEncoder.withIndent('  ');
              print(encoder.convert(json.decode(resp.body)));
            }
          });
        })
      )(
        isSuccess.value == null ? 'Sync Transactions' : isSuccess.value ? 'Success' : 'Failure'
      )
    );
  },
  _$SyncTransactionsInputConfig, // ignore: undefined_identifier
);
