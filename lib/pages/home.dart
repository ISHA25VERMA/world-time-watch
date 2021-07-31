import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty? data : ModalRoute.of(context)!.settings.arguments as Map;
    // print(data);

    Color? bgColor = data['isDay'] ? Colors.teal[200] : Colors.blueGrey[600];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  data['imgUrl']
              ),
              fit: BoxFit.cover,
            )
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 45.0, 0.0, 0.0),
              child: Column(
                children: [
                  TextButton.icon(onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    if (mounted){
                      setState(() {
                        data = result;
                      });
                    }

                  }, icon: Icon(
                    Icons.edit_location,
                    color: Colors.black,
                    size: 20.0,
                  ), label: Text(
                    'Edit Location',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  )),
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
