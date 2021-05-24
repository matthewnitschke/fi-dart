import 'dart:html';

import 'package:dnd/dnd.dart';
import 'package:over_react/over_react.dart';

Ref useDraggable({
  String handle,
  AvatarHandler avatarHandler
}) {
  final ref = useRef();

  useEffect(() {
    final draggable = Draggable(
      ref.current,
      avatarHandler: avatarHandler ?? AvatarHandler.clone(),
      handle: handle,
    );

    return () {
      draggable.destroy();
    };
  }, []);

  return ref;
}

Ref useDropzone({ 
  Acceptor acceptor,
  String overClass,
  void Function(DropzoneEvent) onDrop,
}) {
  final ref = useRef();

  useEffect(() {
    final droppable = Dropzone(
      ref.current,
      acceptor: acceptor,
      overClass: overClass
    );

    var onDropSubscription;
    if (onDrop != null) {
      onDropSubscription = droppable.onDrop.listen(onDrop);
    }

    return () {
      droppable.destroy();
      onDropSubscription?.cancel();
    };
  }, []);

  return ref;
}

class TransactionAcceptor extends Acceptor {
  @override
  bool accepts(Element draggableElement, _, __) {
    return draggableElement.classes.contains('transaction-pill');
  }
}

class TransactionAvatarHandler extends AvatarHandler {
  @override
  void dragStart(Element draggable, Point startPosition) {
    // Clone the draggable to create the avatar.
    avatar = (draggable.clone(true) as Element)
      ..attributes.remove('id')
      ..style.cursor = 'inherit';

    // Ensure avatar has an absolute position.
    avatar.style.position = 'absolute';
    avatar.style.zIndex = '100';
    // avatar.style.width = '${draggable.offsetWidth}px';

    // Add the drag avatar to the parent element.
    draggable.parentNode.append(avatar);

    // Set the initial position of avatar (relative to the closest positioned
    // ancestor).
    final pos = Point(startPosition.x - avatar.offsetWidth/2, startPosition.y - avatar.offsetHeight/2);
    setLeftTop(pos);
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