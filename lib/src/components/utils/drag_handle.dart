import 'package:over_react/over_react.dart';

part 'drag_handle.over_react.g.dart';

mixin DragHandleProps on UiProps {}

UiFactory<DragHandleProps> DragHandle = uiFunction(
  (props) {
    return (Dom.svg()
      ..viewBox = '0 0 8 15'
      ..width = '8'
      ..height = '15'
      ..focusable = false
    )(
      (Dom.path()
        ..fill = '#B6BEC2'
        ..d = 'M1.5 6a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3zm0-6a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3zm0 12a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3zm5-12a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3zm0 6a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3zm0 6a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3z'
      )()
    );
  },
  _$DragHandleConfig, // ignore: undefined_identifier
);


// <svg class="Drag-handle" viewBox="0 0 8 15" width="8" height="15" focusable="false"><path fill="#B6BEC2" d="M1.5 6a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3zm0-6a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3zm0 12a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3zm5-12a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3zm0 6a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3zm0 6a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3z"></path></svg>