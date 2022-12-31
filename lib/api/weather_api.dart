import 'dart:convert';

import '../model/weather_forecast_daily.dart';
import '../utilits/constans.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class WeatherApi{
    Future<WeatherForecast> fetchWeatherForecastWithCity({String? cityName}) async{
        var queryParametres = {
            'appid' : Constants.WEATHER_APP_ID,
            'units' : 'metric',
            'q' : cityName,
        };

        var uri = Uri.http(Constants.WEATHER_BASE_URL_DOMAIN, Constants.WEATHER_FORECAST_PATH, queryParametres);
        
        log('request: ${uri.toString()}');

        var response = await http.get(uri);
        
        print('response:${response.body}');

        if(response.statusCode == 200){
            return WeatherForecast.fromJson(json.decode(response.body));
        } else{
            throw Exception('Error response');
        }
    }
}