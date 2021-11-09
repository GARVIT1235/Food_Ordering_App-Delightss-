import 'package:Delightss/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MapService extends StatefulWidget {
  @override
  _MapServiceState createState() => _MapServiceState();
}

class _MapServiceState extends State<MapService> {
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
    return Center(
        child: Column(
      children: [
        Container(
          height: 300,
          child: FlutterMap(
            options: MapOptions(
                center: currentposition != null
                    ? latLng.LatLng(
                        currentposition.latitude, currentposition.longitude)
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
                            currentposition.latitude, currentposition.longitude)
                        : latLng.LatLng(27.88202, 78.07199),
                    builder: (ctx) => Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        hoverColor: AppColors.main_color,
                        color: AppColors.secondary_color,
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
                      color: AppColors.white, fontWeight: FontWeight.bold),
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
                        color: AppColors.white, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ],
    ));
  }
}
