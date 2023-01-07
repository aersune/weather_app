import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  cursorColor: Colors.blueGrey[800],
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.black87,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none
                    ),
                    icon:Icon(
                      Icons.location_city,
                      color: Colors.black87,
                      size: 50,
                    ),
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
            ),
            TextButton(
                onPressed: (){
                  Navigator.pop(context,cityName);
                },
                child: Text('Get weather', style: TextStyle(fontSize: 30),)
            )
          ],
        ),
      ),
    );
  }
}
