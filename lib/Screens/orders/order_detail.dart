import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/orders/track_order.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/order.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order order;
  final MainModel model;
  OrderDetailsPage(this.order, this.model);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String name = "";

  getLocation() async {
    name = await widget.model.getUserLocation(widget.model.getUser.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Detail"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Column(
          children: [
            Text(
              "This order is from " + widget.order.restaurantId,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text("Item")),
                DataColumn(label: Text("Quantity")),
                DataColumn(label: Text("Total"))
              ],
              rows: widget.order.items
                  .map((item) => DataRow(cells: [
                        DataCell(Text(item['_id']['foodName'])),
                        DataCell(Text(item['quantity'].toString())),
                        DataCell(Text(item['_id']['price'].toString())),
                      ]))
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Sub Total"),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(widget.order.totalPrice.toString() + " ETB"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Delivery Fee"),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(widget.order.shippingFee.toString() + " ETB"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Grand Total"),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                      (widget.order.totalPrice + widget.order.shippingFee)
                              .toString() +
                          " ETB"),
                ),
              ],
            ),
            Container(
              child: Column(
                children: [Text("Delivered to:- "), Text("")],
              ),
            ),
            Divider(),
            Container(
              child: Column(
                children: [
                  Text("Payment Option"),
                  Text("// retrive payment option")
                ],
              ),
            ),
            createButton(widget.order.status)
          ],
        ),
      ),
    );
  }

  Widget createButton(status) {
    Widget button;

   if (status == "assigned") {
      button = ElevatedButton(
        child: Text("Track Order"),
        onPressed: () {
          TrackOrderScreen(widget.order.driverId,widget.model,);
        },
        style: ElevatedButton.styleFrom(
          primary: gPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    } else {
      button = ElevatedButton(
        child: Text("Complete"),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: gPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    }
    return button;
  }
}
