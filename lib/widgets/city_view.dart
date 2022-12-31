import 'package:flutter/material.dart';
import 'package:weather/utilits/forecast_util.dart';

import '../model/weather_forecast_daily.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const CityView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var city = snapshot.data?.city?.name;
    var country = snapshot.data?.city?.country;
    var formattedDate = DateTime.fromMillisecondsSinceEpoch(forecastList![0].dt! * 1000);
    return Container(
      child: Column(
        children: [
          Text(
            '$city,  $country',
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          Text(
            Util.getFotmatattedDate(formattedDate) ,
              style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
