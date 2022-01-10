import 'package:over_react/over_react.dart';

part 'details_handle.over_react.g.dart';

mixin DetailsHandleProps on UiProps {
  bool isSelected;
}

UiFactory<DetailsHandleProps> DetailsHandle = uiFunction(
  (props) {
    return (Dom.div()
      ..className = (ClassNameBuilder()
          ..add('details-handle')
          ..add('details-handle__selected', props.isSelected)
        ).toClassName()
      ..style = props.style
      ..onClick = props.onClick
    )(
      (Dom.i()
        ..className = (ClassNameBuilder()
          ..add('fa-circle')
          ..add('far', !props.isSelected)
          ..add('fas', props.isSelected)
        ).toClassName()
      )()
    );
  },
  _$DetailsHandleConfig, // ignore: undefined_identifier
);
