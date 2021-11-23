//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecom_admin_panel/order_details.dart';
import 'componds/imagess.dart';
import 'models/data_provider.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String pincode;
  String search;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 32, top: 12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: MediaQuery.of(context).size.width < 1000 ? 7 : 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: Icon(Icons.search)),
                            Expanded(
                              flex: 9,
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                cursorColor: Colors.deepPurple,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: "Search orders",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: MediaQuery.of(context).size.width < 1000 ? 3 : 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.black26)),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: dataProvider.regions(null),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButton(
                              value: pincode,
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              isExpanded: true,
                              underline: Container(),
                              hint: Text('Pincode'),
                              style: TextStyle(color: Colors.black),
                              onChanged: (v) {
                                setState(() {
                                  pincode = v;
                                });
                              },
                              items: snapshot.data.documents.map((value) {
                                return DropdownMenuItem(
                                  value: value.data['pincode'].toString(),
                                  child: Text(value.data['pincode'].toString()),
                                );
                              }).toList(),
                            );
                          } else {
                            return Text('Something went wrong');
                          }
                        }),
                  ),
                ),
                SizedBox(width: 8)
              ],
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: dataProvider.orders(search: search, filter: pincode),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(right: 32, top: 12),
                  child: PaginatedDataTable(
                    showCheckboxColumn: false,
                    rowsPerPage: snapshot.data.documents.length == 0
                        ? 1
                        : snapshot.data.documents.length < 10
                            ? snapshot.data.documents.length
                            : 10,
                    columns: [
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('Order ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Phone')),
                      DataColumn(label: Text('Total Amount')),
                      DataColumn(label: Text('Pincode')),
                      DataColumn(label: Text('Status')),
                    ],
                    source: DataSource(context, snapshot.data),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ],
    );
  }
}

class DataSource extends DataTableSource {
  DataSource(this.context, this.rows);

  final BuildContext context;
  QuerySnapshot rows;
  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= rows.documents.length) return null;
    final row = rows.documents[index];
    return DataRow.byIndex(
      selected: false,
      index: index,
      onSelectChanged: (value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    OrderDetails(snapshot: row)));
      },
      cells: [
        DataCell(CircleAvatar(
          backgroundColor: Colors.white,
          child: row != null
              ? Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: MyImage(imageUrl: row.data['image']),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Icon(
                    Icons.photo,
                    color: Colors.white,
                  ),
                ),
        )),
        DataCell(Text('${row.data['booking']}')),
        DataCell(Text('${row.data['name']}')),
        DataCell(Text('${row.data['phone']}')),
        DataCell(Text('₹${row.data['total']}')),
        DataCell(Text('${row.data['pincode']}')),
        DataCell(Container(
            decoration: BoxDecoration(
                color: row.data['status'] == 'Order Completed'
                    ? Colors.green.withOpacity(0.4)
                    : row.data['status'] == 'Order Placed'
                        ? Colors.blue.withOpacity(0.3)
                        : row.data['status'] == 'Order Accepted'
                            ? Colors.amber.withOpacity(0.3)
                            : row.data['status'] == 'Order PickedUp'
                                ? Colors.deepPurple.withOpacity(0.3)
                                : Colors.red.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4)),
            padding: EdgeInsets.all(4),
            child: Text(
              '${row.data['status']}',
              style: TextStyle(
                  color: row.data['status'] == 'Order Completed'
                      ? Colors.green
                      : row.data['status'] == 'Order Placed'
                          ? Colors.blue
                          : row.data['status'] == 'Order Accepted'
                              ? Colors.amber
                              : row.data['status'] == 'Order PickedUp'
                                  ? Colors.deepPurple
                                  : Colors.red,
                  fontWeight: FontWeight.bold),
            ))),
      ],
    );
  }

  @override
  int get rowCount => rows.documents.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
