//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecom_admin_panel/componds/imagess.dart';

import 'models/data_provider.dart';

class OrderDetails extends StatefulWidget {
  final DocumentSnapshot snapshot;
  const OrderDetails({Key key, this.snapshot}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String status;
  DateFormat format = DateFormat.yMMMMd('en_US');
  DateFormat time = DateFormat.jm();
  String delivery;

  @override
  void initState() {
    // TODO: implement initState
    status = widget.snapshot.data['status'];
    delivery = widget.snapshot.data['deliveryBoy'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffebebeb),
        appBar: AppBar(
          elevation: 0,
          title: Text('${widget.snapshot.data['booking']}'),
        ),
        body: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Item Details',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: dataProvider
                                  .orderItems(widget.snapshot.documentID),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.only(bottom: 2),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.18,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: snapshot.data.documents[index]
                                                                    ['image'] !=
                                                                null &&
                                                            snapshot
                                                                .data
                                                                .documents[index]
                                                                    ['image']
                                                                .isNotEmpty
                                                        ? MyImage(
                                                            imageUrl:
                                                                snapshot.data.documents[index]
                                                                    ['image'])
                                                        : Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                0.18,
                                                            width: MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.3,
                                                            child: Icon(Icons.photo_size_select_actual_outlined)),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 7,
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          '${snapshot.data.documents[index]['name']}',
                                                          style: TextStyle(
                                                              fontSize: 18.0,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              letterSpacing:
                                                                  0.5),
                                                        ),
                                                        subtitle: Text(
                                                          snapshot.data.documents[
                                                                      index][
                                                                  'description'] ??
                                                              'Price for ${snapshot.data.documents[index]['quantity']}',
                                                          style: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          padding:
                                                              EdgeInsets.all(6),
                                                          child: Text(
                                                            '${snapshot.data.documents[index]['quantity']}',
                                                            style: TextStyle(),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8,
                                                                top: 4),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                '₹${snapshot.data.documents[index]['price']}X${snapshot.data.documents[index]['pieces']} = ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .black)),
                                                            Text(
                                                                '₹${snapshot.data.documents[index]['total']}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .green)),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      )
                                                    ],
                                                  ))
                                            ]),
                                      );
                                    },
                                  );
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Price Details',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            CustomTile(
                                title: 'Total Cost',
                                tail: '₹${widget.snapshot.data['sub']}',
                                titlestyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 16),
                                tailstyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    fontSize: 16)),
                            CustomTile(
                                title: 'Delivery Charge',
                                tail: '₹${widget.snapshot.data['delivery']}',
                                titlestyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 16),
                                tailstyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    fontSize: 16)),
                            CustomTile(
                                title: 'Sub Total',
                                tail:
                                    '₹${widget.snapshot.data['sub'] + widget.snapshot.data['delivery']}',
                                titlestyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 16),
                                tailstyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    fontSize: 16)),
                            CustomTile(
                                title: 'Discount',
                                tail:
                                    '${((widget.snapshot.data['saving'] / widget.snapshot.data['sub']) * 100).floor()}% OFF',
                                titlestyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 16),
                                tailstyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff6fb840),
                                    fontSize: 16)),
                            CustomTile(
                                title: 'Total Saving',
                                tail: '- ₹${widget.snapshot.data['saving']}',
                                titlestyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 16),
                                tailstyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff6fb840),
                                    fontSize: 16)),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order Total:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        'including all taxes',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹${widget.snapshot.data['total']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'Booking Details',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                    '${widget.snapshot.data['booking']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: Text.rich(TextSpan(
                                    text:
                                        '${format.format(DateTime.fromMicrosecondsSinceEpoch(widget.snapshot.data['booking']))}   ',
                                    style: TextStyle(),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${time.format(DateTime.fromMicrosecondsSinceEpoch(widget.snapshot.data['booking']))}',
                                      )
                                    ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border:
                                          Border.all(color: Colors.black26)),
                                  child: DropdownButton(
                                    value: status,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    isExpanded: true,
                                    underline: Container(),
                                    hint: Text('Status'),
                                    style: TextStyle(color: Colors.black),
                                    onChanged: _update,
                                    items: [
                                      'Order Placed',
                                      'Order Accepted',
                                      'Order PickedUp',
                                      'Order Completed'
                                    ].map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10)
                            ],
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'Customer Details',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                    child: Icon(Icons.person_outline)),
                                title: Text('${widget.snapshot.data['name']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: Text(
                                  '${widget.snapshot.data['phone']}',
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.local_shipping_outlined),
                                title: Text('Shipping Address',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: Text(
                                  '${widget.snapshot.data['address']}',
                                ),
                              ),
                              SizedBox(height: 10)
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'DeliveryBoy Details',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: dataProvider.employee(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.documents.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          leading: Container(
                                              width: 60,
                                              height: 60,
                                              child: MyImage(
                                                imageUrl: snapshot
                                                    .data
                                                    .documents[index]
                                                    .data['image'],
                                              )),
                                          title: Text(
                                              '${snapshot.data.documents[index].data['name']}'),
                                          subtitle: Text(
                                              '${snapshot.data.documents[index].data['phone']}'),
                                          trailing: Radio(
                                            groupValue: delivery,
                                            value: snapshot.data
                                                .documents[index].documentID,
                                            onChanged: (value) {
                                              _deliveryBoy(snapshot
                                                  .data.documents[index]);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                Expanded(flex: 1, child: Container()),
              ],
            ),
            SizedBox(height: 10)
          ],
        ));
  }

  Future _update(String value) async {
    CollectionReference referencer = Firestore.instance.collection('Orders');
    try {
      referencer.document(widget.snapshot.documentID).setData({
        'status': value,
      }, merge: true);
      setState(() {
        status = value;
      });
    } catch (e) {}
  }

  Future _deliveryBoy(DocumentSnapshot snapshot) async {
    CollectionReference referencer = Firestore.instance.collection('Orders');
    try {
      referencer.document(widget.snapshot.documentID).setData({
        'deliveryBoy': snapshot.documentID,
        'boyName': snapshot.data['name'],
        'boyPhone': snapshot.data['phone'],
        'status': 'Order PickedUp'
      }, merge: true);
      setState(() {
        delivery = snapshot.documentID;
        status = 'Order PickedUp';
      });
    } catch (e) {}
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final String tail;
  final TextStyle titlestyle;
  final TextStyle tailstyle;
  CustomTile(
      {@required this.title,
      @required this.tail,
      @required this.titlestyle,
      @required this.tailstyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Row(
        children: [
          Expanded(
            child: Align(
              child: Text(
                '$title',
                style: titlestyle,
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(
            child: Align(
              child: Text(
                '$tail',
                style: tailstyle,
              ),
              alignment: Alignment.centerRight,
            ),
          )
        ],
      ),
    );
  }
}
