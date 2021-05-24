import 'dart:html';

import 'package:dnd/dnd.dart';
import 'package:fi/src/app/components/utils/card.dart';
import 'package:fi/src/app/hooks/dnd-hooks.dart';
import 'package:over_react/over_react.dart';

part 'sortable_card.over_react.g.dart';



class SortableCardProps extends UiProps with CardProps {}

UiFactory<SortableCardProps> SortableCard = uiFunction(
  (props) {

    final draggableRef = useDraggable(
      avatarHandler: CardAvatarHandler(),
      handle: '.drag-handle'
    );

    final dropzoneRef = useDropzone(
      overClass: 'hide'
    );

    return (Card()
      ..addProps(props)
      ..ref = (v) {
        draggableRef.current = v;
        dropzoneRef.current = v;
      }
    )(props.children);
  },
  _$SortableCardConfig, // ignore: undefined_identifier
);



class CardAvatarHandler extends AvatarHandler {
  @override
  void dragStart(Element draggable, Point startPosition) {
    // Clone the draggable to create the avatar.
    avatar = (draggable.clone(true) as Element)
      ..attributes.remove('id')
      ..style.cursor = 'inherit';

    // Ensure avatar has an absolute position.
    avatar.style.position = 'absolute';
    avatar.style.zIndex = '100';
    avatar.style.width = '${draggable.offsetWidth}px';

    // Add the drag avatar to the parent element.
    draggable.parentNode.append(avatar);

    // Set the initial position of avatar (relative to the closest positioned
    // ancestor).
    setLeftTop(draggable.offset.topLeft);
  }

  @override
  void drag(Point startPosition, Point position) {
    setTranslate(position - startPosition);
  }

  @override
  void dragEnd(Point startPosition, Point position) {
    avatar.remove();
  }
}