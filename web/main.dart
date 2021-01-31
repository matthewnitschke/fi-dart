import 'dart:html';

import 'package:fi/fi.dart';
import 'package:over_react/components.dart';
import 'package:react/react_dom.dart' as react_dom;

Future main() async {
  final module = FiModule();
  
  react_dom.render(
    ErrorBoundary()(
      module.content()
    ),
    querySelector('#app')
  );
}