import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SelectTopicsPage extends StatefulWidget {
  final String id;
  const SelectTopicsPage(this.id);

  @override
  _SelectTopicsPageState createState() => _SelectTopicsPageState();
}

class _SelectTopicsPageState extends State<SelectTopicsPage> {
  double _value = 40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: true,
        //   title: Text("Select"),
        // ),
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Choose Price Interval of your interest",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SfSlider(
          min: 0,
          max: 200,
          value: _value,
          interval: 40,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          onChanged: (dynamic value) {
            setState(() {
              _value = value;
            });
          },
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          child: FilterChipWidget(_value, widget.id),
        ),
      ],
    ));
  }
}

class FilterChipWidget extends StatefulWidget {
  final double value;
  final String id;
  FilterChipWidget(this.value, this.id);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  List<String> selectedCategory = [];
  List<String> _options = [
    'Injera',
    'Vegetable',
    'Meat',
    'Western',
    'Traditional',
    'Spicy',
    'Juice',
    'Fish',
    'Bevereges',
    'Sandwiches',
  ];
  List<bool> _selected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  Widget _buildChips(_value) {
    List<Padding> chips = [];

    for (int i = 0; i < _options.length; i++) {
      FilterChip filterChip = FilterChip(
        label: Text(_options[i]),
        labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _selected[i] ? whiteColor : gPrimaryColor),
        selected: _selected[i],
        selectedColor: gPrimaryColor,
        showCheckmark: false,
        onSelected: (bool isSelected) {
          // print("isSelected");
          // print(isSelected);
          setState(() {
            if (isSelected) {
              selectedCategory.add(_options[i]);
              _selected[i] = isSelected;
            } else {
              selectedCategory.remove(_options[i]);
              _selected[i] = isSelected;
            }
          });

          print(selectedCategory);
        },
      );
      chips.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: filterChip,
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select at least three food categories.",
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ],
        ),
        Wrap(
          children: chips,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 25),
          child: ScopedModelDescendant(
              builder: (context, Widget child, MainModel model) {
            return _buildButton(
                selectedCategory, widget.id, _value, model.addCategory);
          }),
        ),
      ],
    );
  }

  Widget _buildButton(List<String> list, id, price, Function addCategory) {
    int number = 0;
    for (int i = 0; i < _selected.length; i++) {
      if (_selected[i] == true) {
        number++;
      }
    }
    if (number >= 3) {
      return ElevatedButton.icon(
        onPressed: () async {
          var response = await addCategory(list, price, id);
          Navigator.pushReplacementNamed(context, '/home');
        },
        style: ElevatedButton.styleFrom(
          primary: gPrimaryColor,
        ),
        label: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text("next"),
        ),
        icon: Icon(Icons.navigate_next),
      );
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildChips(widget.value);
  }
}
