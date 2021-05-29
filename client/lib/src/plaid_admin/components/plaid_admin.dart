import 'dart:convert';

import 'package:fi/src/plaid_admin/models/account.sg.dart';
import 'package:fi/src/plaid_admin/models/serializers.sg.dart';
import 'package:fi/src/utils/requests.dart';
import 'package:over_react/over_react.dart';

part 'plaid_admin.over_react.g.dart';

mixin PlaidAdminProps on UiProps {}

UiFactory<PlaidAdminProps> PlaidAdmin = uiFunction(
  (props) {
    final accounts = useState<List<Account>>([]);
    useEffect(() {
      fetch('/plaid/accounts').then((r) {
        final accountsJson = json.decode(r.body) as List<dynamic>;
        final data = accountsJson.map((accountJson) => serializers.deserializeWith(Account.serializer, accountJson)).toList();
        accounts.set(data);
      });
    }, []);

    return Dom.div()(
      accounts.value.map((account) {
        return Dom.div()('${account.email} - ${account.plaidAccessToken}');
      })
    );
  },
  _$PlaidAdminConfig, // ignore: undefined_identifier
);
