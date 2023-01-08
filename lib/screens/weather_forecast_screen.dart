import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/widgets/bottom_list_view.dart';
import 'package:weather/widgets/city_view.dart';
import 'package:weather/widgets/detail_view.dart';
import 'package:weather/widgets/temp_view.dart';
import '../model/weather_forecast_daily.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;
  const WeatherForecastScreen({Key? key, this.locationWeather}) : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
   String _cityName = 'London';
  // late String  _cityName;

  @override
  void initState() {
    super.initState();
    if(widget.locationWeather != null){
      forecastObject = Future.value(widget.locationWeather);
    }
    //
    // forecastObject.then((weather) {
    //   if (kDebugMode) {
    //     print(weather.list![0].weather![0].main);
    //   }
    // });
  }
  late String city;
  final focus = FocusNode();
  Color whiteColor = Colors.white;
  Color orangeColor = Colors.deepOrangeAccent;
  var inputText =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text('Weather Forecast'),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.my_location),
        //   onPressed: (){
        //     setState(() {
        //       forecastObject = WeatherApi().fetchWeatherForecast();
        //     });
        //   },
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: (){
                setState(() {
                  forecastObject = WeatherApi().fetchWeatherForecast();
                });
              },
            ),
          ),
          // IconButton(onPressed: () async{
          //   var toppedName = await Navigator.push(context, MaterialPageRoute(builder: (context) => const CityScreen()));
          //   if(toppedName != null){
          //     setState(() {
          //       _cityName = toppedName;
          //       forecastObject = WeatherApi().fetchWeatherForecast(cityName: _cityName, isCity: true);
          //       print(_cityName);
          //     });
          //   }
          // }, icon: const Icon(Icons.location_city))
        ],
      ),
      backgroundColor: Colors.deepOrangeAccent,
      body: ListView(
        children: [
          FutureBuilder<WeatherForecast>(
            future: forecastObject,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Column(
                  children: [
                    formField(whiteColor),
                    const SizedBox(height: 30,),
                    CityView(snapshot: snapshot),
                    const SizedBox(height: 30,),
                    TempView(snapshot: snapshot),
                    const SizedBox(height: 30,),
                    DetailView(snapshot: snapshot),
                    const SizedBox(height: 40,),
                    BottomLisView(snapshot: snapshot,),
                  ],
                );
              } else{

                return Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      formField(orangeColor),
                      const SizedBox(height: 20,),
                      const Text('! City not found \n Please, enter correct city !',style: TextStyle(
                        fontSize: 25,
                        color: Colors.red
                      ), textAlign: TextAlign.center,)
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
  Widget formField(Color searchIconColor ){
      return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        child: TextFormField(
          controller: inputText,
          textInputAction: TextInputAction.done,
          autofocus: false,
          cursorColor: Colors.blueGrey[800],
          style: const TextStyle(color: Colors.white, fontSize: 20),
          decoration:  InputDecoration(
            hintText: 'Enter City Name',
            hintStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.deepOrangeAccent,
            border: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none
            ),
            icon:Icon(
              Icons.search,
              color: searchIconColor,
              size: 30,
            ),
            suffixIcon: IconButton(onPressed: () {
              setState(() {
                _cityName = city;
                forecastObject = WeatherApi().fetchWeatherForecast(cityName: _cityName, isCity: true);
              });
            }, icon:  const Icon(Icons.navigate_next_outlined, size: 35, color: Colors.white,)
            ),
          ),
          onChanged: (value) {
            city = value;
          },
          onFieldSubmitted: (value){
            FocusScope.of(context).requestFocus(focus);
            setState(() {
              _cityName = value;
              forecastObject = WeatherApi().fetchWeatherForecast(cityName: _cityName, isCity: true);
            });
            // Navigator.pop(context, cityName);
          },
        ),
      );
  }
}
