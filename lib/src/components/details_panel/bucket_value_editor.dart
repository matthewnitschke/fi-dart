import 'package:fi/src/models/bucket.sg.dart';
import 'package:fi/src/models/bucket_value.sg.dart';
import 'package:fi/src/utils.dart';
import 'package:over_react/over_react.dart';

part 'bucket_value_editor.over_react.g.dart';

mixin BucketValueEditorProps on UiProps {
  BucketValue value;

  void Function(BucketValue) onValueChange;
}

UiFactory<BucketValueEditorProps> BucketValueEditor = uiFunction(
  (props) {
    return (Dom.div()
      ..className = 'bucket-value-editor'
    )(
      (Dom.div()
        ..className = 'bucket-value-editor__type-editor'
      )(
        (Dom.div()
          ..className = props.value is IncomeBucketValue ? 'selected' : ''
          ..onClick = ((_) => props.onValueChange(IncomeBucketValue()))
        )('Income'),
        (Dom.div()
          ..className = props.value is StaticBucketValue ? 'selected' : ''
          ..onClick = ((_) => props.onValueChange(StaticBucketValue()))
        )('Static'),
        (Dom.div()
          ..className = props.value is TableBucketValue ? 'selected' : ''
          ..onClick = ((_) => props.onValueChange(TableBucketValue()))
        )('Table'),
        (Dom.div()
          ..className = props.value is ExtraBucketValue ? 'selected' : ''
          ..onClick = ((_) => props.onValueChange(ExtraBucketValue()))
        )('Extra'),
      ),

      props.value is IncomeBucketValue ? (_InputBucketValueEditor()
        ..value = (props.value as IncomeBucketValue).amount
        ..onValueChange = ((amount) => props.onValueChange(IncomeBucketValue((b) => b
          ..amount = amount
        )))
      )() : null,

      props.value is StaticBucketValue ? (_InputBucketValueEditor()
        ..value = (props.value as StaticBucketValue).amount
        ..onValueChange = ((amount) => props.onValueChange(StaticBucketValue((b) => b
          ..amount = amount
        )))
      )() : null,

      props.value is TableBucketValue ? (_TableBucketValueEditor()
        ..value = props.value as TableBucketValue
        ..onValueChange = props.onValueChange
      )() : null,

      props.value is ExtraBucketValue ? _ExtraBucketValueEditor()() : null,
    );
  },
  _$BucketValueEditorConfig, // ignore: undefined_identifier
);

// ---------------------------------- InputBucketValue ----------------------------------

mixin _InputBucketValueEditorProps on UiProps {
  int value;
  void Function(int) onValueChange;
}

UiFactory<_InputBucketValueEditorProps> _InputBucketValueEditor = uiFunction(
  (props) {
    return Dom.div()(
      (Dom.input()
        ..defaultValue = props.value
        ..type = 'number'
        ..onBlur = ((e) => props.onValueChange(int.parse(e.target.value)))
      )()
    );
  },
  _$_InputBucketValueEditorConfig, // ignore: undefined_identifier
);

// ---------------------------------- InputBucketValue ----------------------------------

mixin _TableBucketValueEditorProps on UiProps {
  TableBucketValue value;
  void Function(BucketValue) onValueChange;
}

UiFactory<_TableBucketValueEditorProps> _TableBucketValueEditor = uiFunction(
  (props) {
    return Dom.div()(
      Dom.table()(
        Dom.thead()(
          Dom.tr()(
            Dom.th()('Name'),
            Dom.th()('Amount'),
            Dom.th()(),
          )
        ),
        Dom.tbody()(
          props.value.entries.map((entry) => (Dom.tr()
            ..key = entry.key
          )(
            Dom.td()(
              (Dom.input()
                ..defaultValue = entry.key
                ..onBlur = ((e) {
                  final i = props.value.entries.indexOf(entry);
                  props.onValueChange(props.value.rebuild((b) => b
                    ..entries[i] = MapEntry(e.target.value as String, entry.value)
                  ));
                })
              )()
            ),
            Dom.td()(
              (Dom.input()
                ..type = 'number'
                ..defaultValue = entry.value
                ..onBlur = ((e) {
                  final i = props.value.entries.indexOf(entry);
                  props.onValueChange(props.value.rebuild((b) => b
                    ..entries[i] = MapEntry(entry.key, double.parse(e.target.value))
                  ));
                })
              )()
            ),
            Dom.td()(
              (Dom.button()
                ..onClick = ((_) {
                  props.onValueChange(props.value.rebuild((b) => b
                    ..entries.remove(entry)
                  ));
                })
              )('-')
            ),
          ))
        )
      ),
      (Dom.button()
        ..onClick = ((_) {
          props.onValueChange(props.value.rebuild((b) => b
            ..entries.add(MapEntry('', 0))
          ));
        })
      )('+')
    );
  },
  _$_TableBucketValueEditorConfig, // ignore: undefined_identifier
);



mixin _ExtraBucketValueEditorProps on UiProps {}

UiFactory<_ExtraBucketValueEditorProps> _ExtraBucketValueEditor = uiFunction(
  (props) {
    final incomeItems = useAppSelector(
      (state) => state.items.values
        .whereType<Bucket>()
        .where((item) => item.value is IncomeBucketValue),
    );

    final expenseItems = useAppSelector(
      (state) => state.items.values
        .whereType<Bucket>()
        .where((item) => item.value is! IncomeBucketValue && item.value is! ExtraBucketValue),
    );

    return Dom.div()(
      Dom.h3()('Income'),
      incomeItems.map((item) => Dom.div()(
        '${item.label}: ${(item.value as IncomeBucketValue).amount}'
      )),

      Dom.h3()('Expense'),
      expenseItems.map((item) => Dom.div()(item.label)),
      
    );
  },
  _$_ExtraBucketValueEditorConfig, // ignore: undefined_identifier
);
