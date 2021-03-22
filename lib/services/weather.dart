import 'package:clima_app/services/networking.dart';
import 'package:clima_app/services/location.dart';

const apiKey = '0cef5949a69d0b61d478691e08fce6a1';
const openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String city) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherURL?q=$city&appid=$apiKey&units=metric&lang=el');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric&lang=el');

    var weatherData = await networkHelper.getData();

    return weatherData;
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
      return 'Καιρός για 🍦';
    } else if (temp > 20) {
      return 'Ήρθε η ώρα για παντόφλα και 👕';
    } else if (temp < 10) {
      return 'Θα χρειαστείς 🧣 και 🧤';
    } else {
      return 'Πάρε ένα 🧥 για κάθε περίπτωση';
    }
  }
}
