import 'package:fi/src/utils/requests.dart';
import 'package:over_react/over_react.dart';
import 'package:http/http.dart' as http;


part 'plaid_admin.over_react.g.dart';

mixin PlaidAdminProps on UiProps {}

UiFactory<PlaidAdminProps> PlaidAdmin = uiFunction(
  (props) {
    useEffect(() {
      fetch('/plaid/accounts').then((r) => print(r));
    }, []);

    return Dom.div()(
      'heyy'
    );
  },
  _$PlaidAdminConfig, // ignore: undefined_identifier
);
