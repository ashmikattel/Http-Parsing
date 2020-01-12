import 'package:flutter/material.dart';

class ChangeCity extends StatefulWidget {
  @override
  _ChangeCityState createState() => _ChangeCityState();
}

class _ChangeCityState extends State<ChangeCity> {
  var _cityFileController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change City'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ), 
      body: Stack(children: <Widget>[
        Center(
          child:Image.asset('image/white_snow.png',
            height: MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width ,
            fit: BoxFit.fill,
            ),
        ),
        ListView(
          children: <Widget>[
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter City',
                ),
                controller: _cityFileController,
                keyboardType: TextInputType.text,
              ),
            ),
            ListTile(
              title: FlatButton(
                child: Text('Get Weather',),
                textColor: Colors.white70,
                color: Colors.red,
                onPressed: (){
                  Navigator.pop(context,{
                    'enter':_cityFileController.text,
                  });
                },
                ),
            )
          ],
        )
      ],
      ),
    );
  }
}