import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SettingsPage extends StatefulWidget{
  final String title;
  SettingsPage({Key key,this.title}) : super(key:key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>{
  @override
  BuildContext context;
  int lanValue = 0;

  @override
  Widget build(BuildContext context) {
    this.context = context;
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
                    Locale newLocale;
                    if(value == 0)
                      newLocale = Locale('en');
                    else
                      newLocale = Locale('zh');
                    setState(() {
                      this.lanValue = value;
                    });
                    setState(() {
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