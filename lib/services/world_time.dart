import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{
  String location; //location name
  late String time;   //time at the locaion
  late String date;
  late String imgUrl; //image hat will change
  String url;//location url
  late bool isDayTime;
  WorldTime({required this.location, required this.url});

  Future<void> getTime() async{

    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      print(response.body);
      Map data = jsonDecode(response.body);
      // print(data['datetime']);
      String datetime = data['datetime'];
      String offset = (data['utc_offset']);
      // print(datetime);
      // print(offset);

      DateTime now =  DateTime.parse(datetime);
      // print(now);

      if (offset[0] == '+'){
        print('add $offset ${offset.substring(1,3)} ${offset.substring(4,6)}');
        now = now.add(Duration(hours: int.parse(offset.substring(1,3)),minutes: int.parse(offset.substring(4,6))));
      }else{
        print('sub $offset ${offset.substring(1,3)} ${offset.substring(4,6)}');
        now = now.subtract(Duration(hours: int.parse(offset.substring(1,3)),minutes: int.parse(offset.substring(4,6))));
      }
      // print(now);

      isDayTime = now.hour >6 && now.hour<20 ? true : false;

      if(isDayTime){
        imgUrl = 'assets/day.jpg';
      }else{
        imgUrl = 'assets/night.jpg';
      }

      time = DateFormat.jm().format(now);
      date = DateFormat.yMMMMd().format(now);

      time = time.toString();
      date = date.toString();
    }catch(e){
      print('caught error');
      time = 'Could not laod time data';
    }


  }

}