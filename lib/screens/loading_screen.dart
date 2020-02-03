import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/weather.dart';
import 'location_screen.dart';
import 'package:clima/services/weather.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getlocation();

    // TODO: implement initState
    super.initState();
  }

  void getlocation() async {
    WeatherModel weatherModel=WeatherModel();
    var wetherData = await weatherModel.getLocationWether();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWether: wetherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitWave(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}
