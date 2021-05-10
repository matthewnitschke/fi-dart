import 'dart:html';

import 'package:over_react/over_react.dart';

Ref onOutsideClick(void Function() trigger) {
  final ref = useRef();

  useEffect(() {
    void _handleClick(e) {
      if (!ref.current.contains(e.target)) {
        trigger();
      }
    }

    document.addEventListener('mousedown', _handleClick);
    return () {
      document.removeEventListener('mousedown', _handleClick);
    };
  }, []);

  return ref;
}