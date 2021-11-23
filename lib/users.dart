//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'banners.dart';
import 'componds/imagess.dart';
import 'models/data_provider.dart';


class UsersView extends StatefulWidget {
  const UsersView({Key key}) : super(key: key);

  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  List<UserData>u=[];
  List<UserData>users=[];

  Future _get()async{
    CollectionReference reference=Firestore.instance.collection('Users');
    try{
      QuerySnapshot querySnapshot=await reference.getDocuments();
      querySnapshot.documents.map((e){
        setState(() {
          u.add(UserData(e.data['profile'], e.data['name'], e.data['number'], e.data['region'], e.data['pincode'].toString(), e.documentID, e.data['token']));
          users=List.from(u);
        });

      }).toList();
    }catch(e){
      print(e.toString());
    }
  }
  onItemChange(String value){
    setState(() {
      users=u.where((test)=>test.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _get();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Card(elevation: 0,child: SizedBox(height: 80,
              child: Container(alignment: Alignment.center,child: Text('Users',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(8)),))),
        ),
        PaginatedDataTable(
          header: Text('Users Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          showCheckboxColumn: false,
          rowsPerPage: users.length==0?1:users.length<10?users.length:10,
          columns: [
            DataColumn(label: Text('Profile')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Phone')),
            DataColumn(label: Text('Region')),
            DataColumn(label: Text('Pincode')),
          ],
          source: DataSource(context,users),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 0,right: 0,top: 4),
              child: Container(padding: EdgeInsets.only(left: 8),height: 40,width: MediaQuery.of(context).size.width*0.2,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.grey.shade200),
                child: TextField(onChanged: onItemChange,
                  showCursor: true,textAlign: TextAlign.left,
                  decoration: InputDecoration(suffixIcon: Icon(Icons.search_rounded),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFF666666),),
                    hintText: "Search your user",
                  ),
                ),
              ),
            ),
            PopupMenuButton(
              icon: Icon(Icons.filter_list),
              tooltip: 'Filter Regions',
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  child: ListTile(
                    title: Text('anantapur'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}



class DataSource extends DataTableSource {
  DataSource(this.context,this.rows);

  final BuildContext context;
  List<UserData> rows;
  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= rows.length) return null;
    final row = rows[index];
    return DataRow.byIndex(selected: false,
      index: index,
      onSelectChanged: (value) {
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>User(row)));
      },
      cells: [
        DataCell(CircleAvatar(backgroundColor: Colors.blue,child: row.profile!=null?Container(
          width: 40,height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: MyImage(imageUrl: row.profile),
          ),
        ):ClipRRect(
          borderRadius: BorderRadius.circular(70),
          child: Icon(Icons.person,color: Colors.white,),
        ),)),
        DataCell(Text('${row.name}')),
        DataCell(Text('${row.phone}')),
        DataCell(Text('${row.region}')),
        DataCell(Text('${row.pincode}')),
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
