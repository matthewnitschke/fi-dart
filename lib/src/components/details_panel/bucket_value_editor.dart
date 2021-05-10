import 'package:fi/src/components/utils/select.dart';
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
      (Select()
        ..onOptionSelect = ((value) {
            if (value == 'income') {
              props.onValueChange(IncomeBucketValue());
            } else if (value == 'static') {
              props.onValueChange(StaticBucketValue());
            } else if (value == 'table') {
              props.onValueChange(TableBucketValue());
            } else if (value == 'extra') {
              props.onValueChange(ExtraBucketValue());
            }
          })
          ..options = {
            'income': 'Income',
            'static': 'Static',
            'table': 'Table',
            'extra': 'Extra'
          }
          ..selectedOption = props.value.name
          ..style = {'marginBottom': '.5rem'}
      )(),

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
  double value;
  void Function(double) onValueChange;
}

UiFactory<_InputBucketValueEditorProps> _InputBucketValueEditor = uiFunction(
  (props) {
    return Dom.div()(
      (Dom.input()
        ..className = 'text-input__amount'
        ..defaultValue = props.value
        ..type = 'number'
        ..onBlur = ((e) => props.onValueChange(double.parse(e.target.value)))
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
            ..key = entry.name
          )(
            Dom.td()(
              (Dom.input()
                ..defaultValue = entry.name
                ..onBlur = ((e) {
                  final i = props.value.entries.indexOf(entry);
                  props.onValueChange(props.value.rebuild((b) => b
                    ..entries[i] = entry.rebuild((eb) => eb..name = e.target.value as String)
                  ));
                })
              )()
            ),
            Dom.td()(
              (Dom.input()
                ..type = 'number'
                ..defaultValue = entry.amount
                ..onBlur = ((e) {
                  final i = props.value.entries.indexOf(entry);
                  props.onValueChange(props.value.rebuild((b) => b
                    ..entries[i] = entry.rebuild((eb) => eb..amount = double.parse(e.target.value))
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
            ..entries.add(TableBucketValueEntry())
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
