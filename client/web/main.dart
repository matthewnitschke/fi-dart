import 'dart:html';

import 'package:fi/fi.dart';
import 'package:fi/src/login/login_module.dart';
import 'package:over_react/components.dart';
import 'package:react/react_dom.dart' as react_dom;

import 'package:react_router/over_react.dart';

Future main() async {
  final module = FiModule();
  final login = LoginModule();
  final plaidAdmin = PlaidAdminModule();
  
  react_dom.render(
    ErrorBoundary()(
      Router()(
        Switch()(
          (Route()
            ..path = '/login'
            ..exact = true
          )(
            login.content()
          )
        ),
        Switch()(
          (Route()
            ..path = '/plaid-admin'
            ..exact = true
          )(
            plaidAdmin.content()
          )
        ),
        Switch()(
          (Route()
            ..path = '/'
            ..exact = true
          )(
            module.content()
          )
        ),
      ),
    ),
    querySelector('#app')
  );
}