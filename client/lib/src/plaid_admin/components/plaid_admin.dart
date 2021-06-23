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
      ..style = { 'textAlign': 'center' }
    )(
      Dom.h1()('Accounts'),
      Dom.div()('Plaid Env: "${env.value}"'),
      (Dom.table()
        ..className = 'pure-table pure-table-bordered'
        ..style = {'margin': '1rem auto'}
      )(
        Dom.thead()(
          Dom.tr()(
            Dom.th()('Email'),
            Dom.th()('Plaid Access Token'),
            Dom.th()(),
          )
        ),
        Dom.tbody()(
          accounts.value.map((account) {
            return (Dom.tr()
              ..key = account.email
            )(
              Dom.td()(account.email),
              Dom.td()(
                (Dom.input()
                  ..style = { 'width': '30rem' }
                  ..defaultValue = account.plaidAccessToken
                  ..onBlur = ((event) {
                    fetch('/plaid-admin/set-user-access-token', body: {
                      'email': account.email,
                      'plaidAccessToken': event.target.value.toString()
                    });
                  })
                )()
              ),
              Dom.td()((TestConnectionButton()..email = account.email)()),
            );
          })
        )
      ),
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


mixin PlaidLinkButtonProps on UiProps {}

UiFactory<PlaidLinkButtonProps> PlaidLinkButton = uiFunction(
  (props) {
    
    
  },
  _$PlaidLinkButtonConfig, // ignore: undefined_identifier
);
