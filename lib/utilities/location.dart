import 'package:geolocator/geolocator.dart';

class Location {
   double? latitude;
   double? longitude;

  Future<void> getCurrentLocation() async{
    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).timeout(const Duration(seconds: 15));
      latitude = position.latitude;
      longitude = position.longitude;
    } catch(e){
        throw 'Something goes wrong $e';
    }
  }

}