import 'package:intl/intl.dart';

class Util{
  static String getFotmatattedDate(DateTime dateTime){
    return DateFormat('EEE, MMM, d, y').format(dateTime);
  }
}