import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import '../services/networking.dart';
import 'networking.dart';
const ApiKey = '5e0481a4876eda7cf8ad51741a6ab4a9';
const OPMurl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel  {
  Future<dynamic> getCityWether (String CityName)
  async{
    var Url='$OPMurl?q=$CityName&appid=$ApiKey&units=metric';
    print(Url);
    NetworkHelp networkHelp=NetworkHelp(url: Url,);
    var wetherData = await networkHelp.getData();
    return wetherData;
  }

  Future<dynamic> getLocationWether () async{
    Location lo = Location();
    await lo.getCurrentlocation();
    NetworkHelp networkHelp = NetworkHelp(
        url:
        '$OPMurl?lat=${lo.longitude}&lon=${lo.longitude}&appid=$ApiKey&units=metric');
    var wetherData = await networkHelp.getData();

    return wetherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
