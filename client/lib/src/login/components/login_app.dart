import 'dart:html';

import 'package:fi/src/utils/requests.dart';
import 'package:over_react/over_react.dart';
import 'package:http/http.dart' as http;

part 'login_app.over_react.g.dart';

mixin LoginAppProps on UiProps {}

UiFactory<LoginAppProps> LoginApp = uiFunction(
  (props) {
    final email = useState('');
    final pass = useState('');

    return (Dom.form()
      ..onSubmit = ((e) {
        e.preventDefault();

        fetch(
          '/login/authenticate', 
          method: FetchMethod.post,
          body: {
            'email': email.value,
            'password': pass.value
          }
        ).then((resp) {
          // if (resp.statusCode < 300) {
          //   final from = Uri.base.queryParameters['from'];
          //   if (from != null) {
          //     window.location.href = from;
          //   } else {
          //     window.location.href = '/';
          //   }
          // }
        });
      })
    )(
      (Dom.input()
        ..value = email.value
        ..onChange = ((e) => email.set(e.target.value))
      )(),
      (Dom.input()
        ..type = 'password'
        ..value = pass.value
        ..onChange = ((e) => pass.set(e.target.value))
      )(),
      (Dom.input()
        ..type = 'submit'
      )()
    );
  },
  _$LoginAppConfig, // ignore: undefined_identifier
);
