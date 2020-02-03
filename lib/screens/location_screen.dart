import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.locationWether});
  final locationWether;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
 double temprature;
 int id;
 String place;
 var wethericon;
 var wethermessage;
 var cityName;
  @override
  void initState() {

    updateUI(widget.locationWether);
    super.initState();
  }

  void updateUI(dynamic wetherData) {
    print(wetherData);
    if(wetherData== null){
    temprature=0;
    wethericon='Error';
    wethermessage='Unable To Get Wether Data';
    cityName='';
    return;

    }
     setState(() {
       temprature = wetherData['main']['temp'];
       id = wetherData['weather'][0]['id'];
       cityName=wetherData['name'];
       wethericon=wether.getWeatherIcon(id);
       wethermessage=wether.getMessage(temprature.toInt());


     });

  }

  @override
  WeatherModel wether = WeatherModel();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                     var wetherData =await wether.getLocationWether();
                     print(wetherData);
                     updateUI(wetherData);
                     },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var result;
                      result= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if(result != null)
                        {
                         var wetherData= await wether.getCityWether(result);
                         updateUI(wetherData);
                        }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temprature.toInt()}°',
                      style: kTempTextStyle,
                    ),
                    Text(wethericon
                      ,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  wethermessage+' in '+cityName,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


