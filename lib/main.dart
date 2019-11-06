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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
          title: Text(widget.title),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.school)),
              Tab(icon: Icon(Icons.map)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            characterPage.build(context),
            academicPage.build(context),
            mapPage.build(context),
          ],
        ),
      ),
    );
  }
}
