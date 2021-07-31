import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:world_time/services/world_time.dart';

class LocationList{

  late List<WorldTime> listCountries = [];

  Future<void> getList() async{
    try {
      Response countries = await get (Uri.parse('http://worldtimeapi.org/api/timezone'));
      // print(countries.body);
      var jsonList = jsonDecode(countries.body);
      List<String> country = List.from(jsonList);
      int count = country.length;

      for (int i = 0; i<count;i++){
        int j = country[i].lastIndexOf('/');
        listCountries.add(WorldTime(location: country[i].substring(j+1), url: country[i].replaceAll('_', ' ')));
      }
    }catch(e){
      print('error getting list of countries');
    }

  }
}