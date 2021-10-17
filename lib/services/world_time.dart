import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  late String location;
  late String time;
  late String flag; // url for flag icon
  late String url;
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});
  
  Future<void> getTime() async {
    try{
      //make the request and get the response
      var uri = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(uri);
      Map data = jsonDecode(response.body);

      // get properties from response data
      String datetimeString = data['datetime'];
      String offset = data['utc_offset'].toString().substring(1,3);
      DateTime dateTime = DateTime.parse(datetimeString);
      dateTime = dateTime.add(Duration(hours: int.parse(offset)));

      isDaytime = dateTime.hour <6 && dateTime.hour < 19 ? true : false;

      time = DateFormat.jm().format(dateTime);
    }catch(error){
      print('caught error : $error');
      time = 'Could not find time';
    }

  }
}
