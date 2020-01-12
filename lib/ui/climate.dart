import 'package:flutter/material.dart';
import '../util/util.dart' as util;
import 'dart:async';
import 'dart:convert';
import 'secondPage.dart';
import 'package:http/http.dart' as http;

class Climatic extends StatefulWidget {
  @override
  _ClimaticState createState() => _ClimaticState();
}

class _ClimaticState extends State<Climatic> {
  String _cityEntered;


  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
        return ChangeCity();
    }));
    if(results !=null && results.containsKey('enter')){
      _cityEntered = results['enter'];
    }
  }

  void showWeather() async {
    Map data = await getWeather(util.apiId, util.defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Climate App'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(icon: new Icon(Icons.menu), onPressed: (){_goToNextScreen(context);})
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'image/umbrella.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: Text(
              '${_cityEntered == null? util.defaultCity:_cityEntered}',
              style: cityStyle()
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('image/light_rain.png'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 330, 0, 0),
            alignment: Alignment.center,
            child: updateTempWidget(_cityEntered),
            
          )
        ],
      ),
    );
  }
  TextStyle tempStyle(){
    return TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 49.9);}
  TextStyle cityStyle(){
    return TextStyle(
                  fontSize: 22.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white);
  }                
  
  }

  Future<Map> getWeather(String appId, String city) async {
    String apiURL =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appId=${util.apiId}&units=metric';
    http.Response response = await http.get(apiURL);
    return jsonDecode(response.body);
  }

  Widget updateTempWidget(String city) {
    return FutureBuilder(
      future: getWeather(util.apiId, city==null?util.defaultCity:city),
         builder:(BuildContext context, AsyncSnapshot<Map> snapshot ){
            if(snapshot.hasData){
              Map content = snapshot.data;
              return Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(content['main']['temp'].toString()+' C',
                      style: TextStyle(fontStyle: FontStyle.normal,
                      fontSize: 49.9,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                      ),
                      subtitle: ListTile(
                        title: Text("Humidity:${content['main']['humidity'].toString()}\n"
                        "min:${content['main']['temp_min'].toString()} C\n"
                        "max:${content['main']['temp_max'].toString()} C",
                        style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }  
            else
            return Container();        
        });
  }
