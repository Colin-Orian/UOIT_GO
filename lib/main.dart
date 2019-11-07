import 'package:flutter/material.dart';
import 'CharacterPage.dart';
import 'AcademicPage.dart';
import 'MapPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    characterPage = CharacterPage();
    academicPage =AcademicPage();
    mapPage =MapPage();

    return DefaultTabController(
      length: 3,
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
          children: <Widget>[
            characterPage.build(context),
            mapPage,
            academicPage.build(context),
            
          ],
        ),
      ),
    );
  }
}
