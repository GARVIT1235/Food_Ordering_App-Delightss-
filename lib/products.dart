//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecom_admin_panel/product_details.dart';

import 'componds/product_view.dart';
import 'models/data_provider.dart';

class Products extends StatefulWidget {
  const Products({Key key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  String search;
  String filter;

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
                                  setState(() {
                                    search = v;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Search products",
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
                        stream: dataProvider.category(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButton(
                              value: filter,
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              isExpanded: true,
                              underline: Container(),
                              hint: Text('Category'),
                              style: TextStyle(color: Colors.black),
                              onChanged: (v) {
                                setState(() {
                                  filter = v;
                                });
                              },
                              items: snapshot.data.documents.map((value) {
                                return DropdownMenuItem(
                                  value: value.data['tag'].toString(),
                                  child: Text(value.data['tag'].toString()),
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
        SizedBox(height: 10),
        StreamBuilder<QuerySnapshot>(
            stream: dataProvider.products(search: search, filter: filter),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.documents.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 3 / 2),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.hasData) {
                      return snapshot.data.documents.length > 0
                          ? ProductView(
                              image: snapshot.data.documents[index]['image'],
                              name: snapshot.data.documents[index]['name'],
                              description: snapshot.data.documents[index]
                                  ['description'],
                              quantity: snapshot.data.documents[index]
                                  ['quantity'],
                              mrp: snapshot.data.documents[index]['mrp']
                                  .toString(),
                              wholesale: snapshot
                                  .data.documents[index]['selling']
                                  .toString(),
                              onClick: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ProductDetails(
                                                snapshot: snapshot
                                                    .data.documents[index])));
                              },
                              onDelete: () async {
                                await snapshot.data.documents[index].reference
                                    .delete();
                              },
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      'Loading....',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80, right: 80),
                                    child: Text(
                                      "We are looking to match best product for you",
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            );
                    }
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              'Loading....',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 80, right: 80),
                            child: Text(
                              "We are looking to match best product for you",
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            })
      ],
    );
  }
}
