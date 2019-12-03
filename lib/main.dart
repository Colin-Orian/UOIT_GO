import 'package:flutter/material.dart';

import 'Character.dart';
import 'CharacterPage.dart';
import 'AcademicPage.dart';
import 'MapPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Character.loadCharacter(health: 100.0, motivation: 100.0, numInv: 54, characterName: 'Amazing Student');
    return MaterialApp(
      title: 'Ontario Tech Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ontario Tech Go'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  CharacterPage characterPage;
  AcademicPage academicPage;
  MapPage mapPage;

  _MyHomePageState(){

  }
  @override
  Widget build(BuildContext context) {
    characterPage = CharacterPage();
    academicPage =AcademicPage();

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(
                Icons.person,
                color: Colors.orange,)),
              Tab(icon: Icon(Icons.map,
                color: Colors.orange,)),
              Tab(icon: Icon(Icons.school,
                color: Colors.orange,)),
              
            ],
            indicatorWeight: 5,
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(), //Disable the swipe because it messed up with the map
          children: <Widget>[
            characterPage,
            //We need the Builder to make the snackbar to work
            Builder(builder: (BuildContext context){return MapPage(context: context,);},), 
            AcademicPage(),
          ],
        ),
      ),
    );
  }
}
