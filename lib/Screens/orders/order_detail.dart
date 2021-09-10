import 'package:flutter/material.dart';
import 'package:gebeta_food/models/order.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order order;
  OrderDetailsPage(this.order);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
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
              rows:
                  
                  widget.order.items
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
                   child: Text(widget.order.totalPrice.toString()+" ETB"),
                 ),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Text("Delivery Fee"),
                 Padding(
                   padding: const EdgeInsets.only(left: 16.0),
                   child: Text(widget.order.shippingFee.toString()+" ETB"),
                 ),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Text("Grand Total"),
                 Padding(
                   padding: const EdgeInsets.only(left: 16.0),
                   child: Text((widget.order.totalPrice + widget.order.shippingFee).toString()+" ETB"),
                 ),
               ],
             ),
            Container(
              child: Column(
                children: [
                  Text("Delivered to:- "),
                  Text("//retrive location here")
                ],
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
            )
          ],

        ),
      ),
    );
  }
}
