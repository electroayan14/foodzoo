import 'package:flutter/material.dart';
import 'package:foodzoo/features/location/widgets/location_widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../routes/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _currentAddress = "";
  bool showLoader=false;
  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: locationView(()async{
        setState(() {
          showLoader=true;
        });
        PermissionStatus location = await Permission.location.request();
        if(location.isGranted){
          _getCurrentLocation();
        }
    },
          _currentAddress,showLoader
    ));
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
        showLoader=false;
        print("location!! ${_currentAddress}");
        Future.delayed(Duration(seconds: 1),(){
          Navigator.pushNamed(context, dashboardScreen);
        });
      });
    } catch (e) {
      print("errorlocation $e");
    }
  }

}

