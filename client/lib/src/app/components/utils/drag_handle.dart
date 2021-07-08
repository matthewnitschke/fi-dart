import 'dart:html';

import 'package:over_react/over_react.dart';

part 'drag_handle.over_react.g.dart';

mixin DragHandleProps on UiProps {
  void Function() onMoveUp;
  void Function() onMoveDown;
}

UiFactory<DragHandleProps> DragHandle = uiFunction(
  (props) {
    final isDragging = useState(false);
    final dragStartY = useRef<num>(0);

    void _onMouseMove(Event e) {
      final event = e as MouseEvent;

      final currentY = event.client.y;
      if (currentY > dragStartY.current + 50) {
        props.onMoveDown?.call();
        dragStartY.current = currentY;
      } else if (currentY < dragStartY.current - 50) {
        props.onMoveUp?.call();
        dragStartY.current = currentY;
      }
    }

    void _onMouseUp(_) {
      isDragging.set(false);
      window.removeEventListener('mousemove', _onMouseMove);
      window.removeEventListener('mouseup', _onMouseUp);
      document.getElementById('selectPreventer').remove();
    }

    return (Dom.svg()
      ..className = 'drag-handle ${isDragging.value ? 'dragging' : ''}'
      ..viewBox = '0 0 8 15'
      ..width = '8'
      ..height = '15'
      ..focusable = false
      ..onMouseDown = ((e) {
        isDragging.set(true);
        dragStartY.current = e.clientY;
        window.addEventListener('mousemove', _onMouseMove);
        window.addEventListener('mouseup', _onMouseUp);

        document.head.append(
          StyleElement()
            ..id = 'selectPreventer'
            ..innerHtml = 'body { user-select: none; }'
        );
      })
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