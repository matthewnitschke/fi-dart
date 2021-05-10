import 'dart:html';

import 'package:dnd/dnd.dart';
import 'package:over_react/over_react.dart';

Ref useDraggable({String handle}) {
  final ref = useRef();

  useEffect(() {
    final draggable = Draggable(
      ref.current,
      avatarHandler: AvatarHandler.clone(),
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
  void Function(DropzoneEvent) onDrop,
}) {
  final ref = useRef();

  useEffect(() {
    final droppable = Dropzone(
      ref.current,
      acceptor: acceptor,
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