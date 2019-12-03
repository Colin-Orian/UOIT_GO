import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SettingsPage extends StatefulWidget{
  final String title;
  BuildContext context;
  SettingsPage({Key key,this.title,this.context}) : super(key:key);

  @override
  SettingsPageState createState() => SettingsPageState(context);
}

class SettingsPageState extends State<SettingsPage>{
  @override
  BuildContext context;
  int lanValue = 0;
  Locale newLocale;
  
  SettingsPageState(BuildContext context){
    this.context=context;
    if(!mounted){
      SharedPreferences.setMockInitialValues({"languageNum":0});
    }else{
        _setInt("languageNum", 0);
    }
  }

  Future<int> _getInt(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }
  _setInt(String key,int n) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, n);
  }

  @override
  Widget build(BuildContext context) {
    _getInt("languageNum").then((val){
                        lanValue = val;
                      });
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(
            child: Row(
              children: <Widget>[
                Text("Language"),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
                DropdownButton(
                  value: lanValue,
                  onChanged: (value){
                    if(value == 1)
                      newLocale = Locale('zh');
                    else
                      newLocale = Locale('en');
                    setState(() {
                      _setInt("languageNum", value);
                      _getInt("languageNum").then((val){
                        lanValue = val;
                      });
                      _getInt("languageNum").then((val){
                        print(val);
                      });
                      FlutterI18n.refresh(context, newLocale);
                    });
                  },
                  items: <DropdownMenuItem>[
                    DropdownMenuItem(
                      child: Text("English"),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text("Chinese"),
                      value: 1,
                    )
                  ],
                )
              ],
            )
          )
         
        ],
      ),
    );
  }
}