import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather/api/weather_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/widgets/city_view.dart';
import 'package:weather/widgets/temp_view.dart';
import '../model/weather_forecast_daily.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  final String _cityName = 'London';

  @override
  void initState() {
    super.initState();
    forecastObject =
        WeatherApi().fetchWeatherForecastWithCity(cityName: _cityName);

    // forecastObject.then((weather) {
    //   if (kDebugMode) {
    //     print(weather.list![0].weather![0].main);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('openweathermap.org'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: (){},
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.location_city))
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: FutureBuilder<WeatherForecast>(
              future: forecastObject,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      const SizedBox(height: 50,),
                      CityView(snapshot: snapshot),
                      const SizedBox(height: 50,),
                      TempView(snapshot: snapshot),
                    ],
                  );
                } else{
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.black87,
                      size: 100.0 ,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
