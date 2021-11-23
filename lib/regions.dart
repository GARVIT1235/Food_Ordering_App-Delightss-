//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'models/data_provider.dart';

class Regions extends StatefulWidget {


  @override
  _RegionsState createState() => _RegionsState();
}

class _RegionsState extends State<Regions> {

  TextEditingController _cityController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _deliveryChargeController = TextEditingController();
  String search='';



  void _addRegion() {
    CollectionReference reference=Firestore.instance.collection('Regions');
    try{
      reference.document().setData({
        'city':_cityController.text,
        'region':_regionController.text,
        'delivery':_deliveryChargeController.text,
        'pincode':_pincodeController.text
      });
      Navigator.pop(context);
    }catch(e){
      print(e);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 32),
          child: Card(elevation: 0,child: SizedBox(height: 80,
              child: Container(alignment: Alignment.center,child: Text('Service Regions',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(8)),))),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: dataProvider.regions(null),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Padding(
                  padding: const EdgeInsets.only(top: 12,right: 32),
                  child: PaginatedDataTable(
                    header: Text('Region Details', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    showCheckboxColumn: false,
                    dataRowHeight: 60,
                    rowsPerPage: snapshot.data.documents.length==0?1: snapshot.data.documents.length < 6?snapshot.data.documents.length: 5,
                    columns: [
                      DataColumn(
                          label: Text(
                            'City',
                          )),
                      DataColumn(
                          label: Text(
                            'Region',
                          )),
                      DataColumn(
                          label: Text(
                            'Delivery Charge',
                          )),
                      DataColumn(
                          label: Text(
                            'Pin code',
                          )),
                      DataColumn(
                          label: Text(
                            '',
                          )),
                    ],
                    source: DataSource(context, snapshot.data.documents),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0, top: 4),
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              color: Colors.grey.shade200),
                          child: TextField(
                            onChanged: (v){
                              setState(() {
                                search=v;
                              });
                            },
                            showCursor: true,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search_rounded),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              hintText: "Search for region",
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Add New',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          color: Colors.green,
                          onPressed: _dailog),
                    ],
                  ),
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      ],
    );
  }

  _dailog(){
    showDialog(
        context: context,
        builder: (context,) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(width: MediaQuery.of(context).size.width*0.4,
              child: Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  Center(
                      child: Text("Add New region Details", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87))
                  ),
                  SizedBox(height: 12),
                  Center(
                      child: _textField(_cityController, 'City Name')
                  ),
                  SizedBox(height: 8),
                  Center(
                      child: _textField(_regionController, 'Enter Region')
                  ),
                  SizedBox(height: 8),
                  Center(
                      child: _textField(_pincodeController, 'Enter pincode')
                  ),
                  SizedBox(height: 8),
                  Center(
                      child: _textField(_deliveryChargeController, 'enter Delivery Charge')
                  ),
                  SizedBox(height: 12),
                  Center(
                    child: Container(width: MediaQuery.of(context).size.width*0.3,height: 40,
                      child: RaisedButton(elevation: 0,onPressed: (){
                        if(_cityController.text!=null&&
                            _regionController.text!=null&&
                            _pincodeController.text!=null&&_deliveryChargeController.text!=null){
                          _addRegion();
                        }
                        else{
                          Navigator.pop(context);
                        }
                      },child: Text('Add Region',style: TextStyle(color: Colors.white)),color: Colors.green,),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          );
        });
  }

  _textField(TextEditingController controller,String hint){
    return Container(width: MediaQuery.of(context).size.width*0.3,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,),
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: controller,
        autofocus: false,
        decoration: InputDecoration(
          hintText: '$hint',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(
              20.0, 10.0, 20.0, 10.0),
        ),
      ),
    );
  }
}


class DataSource extends DataTableSource {
  DataSource(this.context, this.rows);

  final BuildContext context;
  List<DocumentSnapshot> rows;
  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= rows.length) return null;
    final row = rows[index];
    return DataRow.byIndex(
      selected: false,
      index: index,
      onSelectChanged: (value) {

      },
      cells: [
        DataCell(Text(
          '${row.data['city']}',
        )),
        DataCell(Text(
          '${row.data['region']}',
        )),
        DataCell(Text(
          '${row.data['delivery']}',
        )),
        DataCell(Text(
          '${row.data['pincode']}',
        )),
        DataCell(IconButton(icon: Icon(Icons.delete_outline),onPressed: () async {
          CollectionReference reference=Firestore.instance.collection('Regions');
          try{
            await reference.document(row.documentID).delete();
          }catch(e){

          }
        },)),
      ],
    );
  }

  @override
  int get rowCount => rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}