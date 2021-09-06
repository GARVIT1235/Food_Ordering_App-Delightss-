import 'package:Delightss/Models/users.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:provider/provider.dart';

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
  TextEditingController phone = TextEditingController();
  UserModel _userModel;
  final _formKey = GlobalKey<FormState>();

  String currentAddress = 'Current Address';
  Position currentposition;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress =
            "${place.name},${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            'User Detail',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
                0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: <Color>[Colors.deepOrange, Colors.deepOrangeAccent],
          )),
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(children: [
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
                        SizedBox(
                          width: 10,
                        ),
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      child: TextFormField(
                        controller: dob,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Date of Birth';
                          }
                          if (value.length != 10) {
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(
                          width: 10,
                        ),
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
                                  'Male',
                                  'Female'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      child: TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Phone No.';
                          }
                          if (value.length != 10) {
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
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Column(
                      children: [
                        Container(
                          height: 300,
                          child: FlutterMap(
                            options: MapOptions(
                                center: currentposition != null
                                    ? latLng.LatLng(currentposition.latitude,
                                        currentposition.longitude)
                                    : latLng.LatLng(27.88202, 78.07199),
                                zoom: 14.0),
                            layers: [
                              TileLayerOptions(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c']),
                              MarkerLayerOptions(
                                markers: [
                                  Marker(
                                    width: 50.0,
                                    height: 50.0,
                                    point: currentposition != null
                                        ? latLng.LatLng(
                                            currentposition.latitude,
                                            currentposition.longitude)
                                        : latLng.LatLng(27.88202, 78.07199),
                                    builder: (ctx) => Container(
                                      child: IconButton(
                                        icon: Icon(Icons.location_on),
                                        hoverColor: Colors.deepOrange,
                                        color: Colors.deepOrangeAccent,
                                        onPressed: () {
                                          _determinePosition();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  currentAddress,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                  onPressed: () {
                                    _determinePosition();
                                  },
                                  child: Text(
                                    'Locate me',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ))
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
                        saveData(context);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Text("Submit",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> saveData(BuildContext context) async {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    if (_formKey.currentState.validate()) {
      Map<String, String> map = Map();
      map["name"] = firstName.text.trim() + " " + lastName.text.trim();
      map["address"] = currentAddress;
      map["age"] = age.text;
      map["dob"] = dob.text;
      map["gender"] = gender;
      map["lat"] = currentposition.latitude.toString();
      map["lon"] = currentposition.longitude.toString();
      map["phone"] = phone.text;
      loginService.addUserToFirestore(map);
      loginService.registerToFirestore();
      Navigator.of(context).pushReplacementNamed('/home');
      sendEmail();
    }
  }

  Future<void> sendEmail() async {}
}
