import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';

class SelectTopicsPage extends StatelessWidget {
  const SelectTopicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: true,
        //   title: Text("Select"),
        // ),
        body: ListView(
      children: [
        Container(
          child: FilterChipWidget(),
        ),
      ],
    ));
  }
}

class FilterChipWidget extends StatefulWidget {
  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  List<String> _options = [
    'Burger',
    'ertib',
    'kitfo',
    'tibes',
    'raw meat',
    'shiro',
    'doro',
    'fruits',
    'juices',
    'Pizza',
    'Traditional',
    'steak',
    'fish',
    'milkshake',
    'Korean',
    'Japanise',
    'Mexican',
    'Chicken',
    'italian',
    'traditional coffee',
    'Coffee',
    'Bevereges',
    'Snacks and siders',
    'desserts',
    'salads',
    'indian',
    'icecream',
    'cakes',
    'Barbecue',
    'Tacos',
    'sandwiches',
    'Noodles'
    'waffles',
    'pancakes',
    'macchiato',
    'hot dog',
    'meatloaf',
    'macaroni and cheese',
    'spaghetti',
    'meatballs',
    'salmon',
    'Grill',
    'combo',
    'shawarma'
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
    false,
    false,
    false,
    false,
    false,
  ];

  Widget _buildChips() {
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
          setState(() {
            _selected[i] = isSelected;
          });
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
            _buildButton(_selected),
          ],
        ),
        Wrap(
          children: chips,
        ),
      ],
    );
  }

  Widget _buildButton(List<bool> list) {
    int number = 0;
    for (int i = 0; i < _selected.length; i++) {
      if (_selected[i] == true) {
        number++;
      }
    }
    if (number >= 3) {
      return ElevatedButton.icon(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        label: Text("next"),
        icon: Icon(Icons.navigate_next),
      );
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildChips();
  }
}
