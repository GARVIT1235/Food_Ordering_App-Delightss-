import 'package:Delightss/Services/Map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController dob = TextEditingController();
  String gender = 'Male';
  String address;
  TextEditingController phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('User Detail',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30))),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                colors: <Color>[
                 Colors.deepOrange,
                 Colors.deepOrangeAccent
                ],
              )),
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      controller: firstName,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter first name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'First Name',
                                        border: InputBorder.none,
                                        fillColor: Colors.grey[300],
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      controller: lastName,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter last name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Last Name',
                                        border: InputBorder.none,
                                        fillColor: Colors.grey[300],
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Container(
                              height: 60,
                              child: TextFormField(
                                controller: dob,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Date of Birth';
                                  }
                                  if (value.length!=10 ) {
                                    return 'Enter in Format';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Date of Birth : DD/MM/YYYY',
                                  border: InputBorder.none,
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      controller: age,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Age';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Age',
                                        border: InputBorder.none,
                                        fillColor: Colors.grey[300],
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 50,
                                    color: Colors.grey[300],
                                    child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: gender,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        underline: Container(
                                          color: Colors.grey[300],
                                          height: 2,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            gender = newValue;
                                          });
                                        },
                                        items: <String>[
                                         'Male', 'Female'
                                        ].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                    )
                                  ),
                                )],
                            ),
                            SizedBox(height: 20,),
                            Container(
                              height: 60,
                              child: TextFormField(
                                controller: phone,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Phone No.';
                                  }
                                  if (value.length!=10) {
                                    return 'Enter Correct Number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Phone No. 9345789756',
                                  border: InputBorder.none,
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            MapService()
                          ]),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                      margin: EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: () {
                            saveData();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2)
                              ),
                              child: Text("Submit",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                          ),
                        ),
                      )
                  ),
                ]),
                ),
              ),
      ),
    );
  }

  Future<void> saveData() async {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushReplacementNamed('/home');
      sendEmail();
    }
  }

  Future<void> sendEmail() async {

  }
}