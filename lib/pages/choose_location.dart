import 'package:flutter/material.dart';
import 'package:world_time/services/list_locations.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> countries = [WorldTime(location: 'loading locations', url: 'Asia/Kolkata')];

  setUpLocationList() async{
    LocationList list = LocationList();
    await list.getList();
    setState(() {
      countries = list.listCountries;
    });
    // print(countries);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpLocationList();
  }

  void updateTime(index) async{
    WorldTime instance = countries[index];
    await instance.getTime();
    //navigate to home screen
    Navigator.pop(context, {
      'location' : instance.location,
      'time': instance.time,
      'imgUrl': instance.imgUrl,
      'date': instance.date,
      'isDay': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Choose a location'
        ),
        elevation: 0,
        centerTitle: true,
      ),
       body:
      ListView.builder(itemCount: countries.length,itemBuilder: (context, index){
        return Card(
          child: ListTile(
            onTap: (){
              updateTime(index);
              // print(countries[index].url);
            },
              title: Text(countries[index].location),
          ),
        );
      })
    );
  }
}
