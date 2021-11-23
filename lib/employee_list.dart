//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'componds/imagess.dart';
import 'models/data_provider.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key key}) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<EmployeeData> em = [];
  List<EmployeeData> employee = [];
  Future _get() async {
    CollectionReference reference = Firestore.instance.collection('Employee');
    try {
      QuerySnapshot querySnapshot = await reference.getDocuments();
      querySnapshot.documents.map((e) {
        setState(() {
          em.add(EmployeeData(
              e.data['image'],
              e.data['name'],
              e.data['role'],
              e.data['phone'],
              e.data['mail'],
              e.data['no'],
              e.data['licence']));
          employee = List.from(em);
        });
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }

  onItemChange(String value) {
    setState(() {
      employee = em
          .where(
              (test) => test.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
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
          child: Card(
              elevation: 0,
              child: SizedBox(
                  height: 80,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Delivery Boys',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8)),
                  ))),
        ),
        PaginatedDataTable(
          header: Text(
            'Delivery Boys',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          showCheckboxColumn: false,
          rowsPerPage: employee.length == 0
              ? 1
              : employee.length < 10
                  ? employee.length
                  : 10,
          columns: [
            DataColumn(label: Text('Profile')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Mail')),
            DataColumn(label: Text('Phone')),
            DataColumn(label: Text('Role')),
            DataColumn(label: Text('Vehicle NO')),
            DataColumn(label: Text('Licence')),
          ],
          source: DataSource(context, employee),
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
                  onChanged: onItemChange,
                  showCursor: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search_rounded),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Color(0xFF666666),
                    ),
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
  DataSource(this.context, this.rows);

  final BuildContext context;
  List<EmployeeData> rows;
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
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>User(row)));
      },
      cells: [
        DataCell(CircleAvatar(
          backgroundColor: Colors.blue,
          child: row.profile != null
              ? Container(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: MyImage(imageUrl: row.profile),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
        )),
        DataCell(Text('${row.name}')),
        DataCell(Text('${row.mail}')),
        DataCell(Text('${row.number}')),
        DataCell(Text('${row.role}')),
        DataCell(Text('${row.vechileNo}')),
        DataCell(Text('${row.licence}')),
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
