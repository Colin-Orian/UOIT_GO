import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'Course.dart';

//test


class GraduationPage extends StatefulWidget{
  final String title;
  List<Course> courses;
  GraduationPage({Key key,this.title,this.courses}) : super(key:key);

  @override
  GraduationPageState createState() => GraduationPageState(courses:this.courses);
}

class GraduationPageState extends State<GraduationPage>{
  List<Course> courses;

  GraduationPageState({this.courses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed:(){
            setState(() {
              Navigator.of(context).pop();
            });
          } 
        ),
        title: Text("Graduation Progress"),
      ),
      body: ListView(
        children: <Widget>[
          _buildPie(context),
          _buildTable(context),
        ],
      ),
    );
  }

  Widget _buildTable(BuildContext context){
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text('Courses'),
        ),
        DataColumn(
          label: Text('Passed/Failed'),
        ),
      ],
      rows: courses.map( (course) => DataRow(
          cells: <DataCell>[
            DataCell(Text(course.courseId +
                           "\n" + 
                           course.courseName)),
            DataCell(Text(course.passed? "Passed" : "Failed",style: TextStyle(
              color: course.passed ?  Color.fromARGB(255, 110, 255, 174): 
                                      Color.fromARGB(255, 255, 99, 84),
              shadows: [
                Shadow(
                  blurRadius: 2.0,
                  color: Colors.black,
                  offset: Offset(0.5,1.0),
                )
              ]
            ),)),
          ],
        ),
      ).toList(),
    );
  }

  Widget _buildPie(BuildContext context){
    var passNum=0;  
    var failedNum=0;

    for (int i=0 ;i<courses.length;i++){
      if(courses[i].passed)
        passNum++;
      else
        failedNum++;
    }

    var data = [passNum,failedNum];


    return Container(
      padding: EdgeInsets.all(18.0),
      width: MediaQuery.of(context).size.width-18.0*2,
      height: MediaQuery.of(context).size.width-18.0*2,
      child: charts.PieChart(
        [
          charts.Series<int, int>(
            id: "Passed",
            colorFn: (int d,int n) => n == 0 ? 
            charts.Color.fromHex(code: "#6AFFAE"):
            charts.Color.fromHex(code: "#FF6354"),
            // colorFn:  (_, __) => charts.MaterialPalette.green.shadeDefault,
            domainFn: (int n,_) => n,
            measureFn: (int n,_) => n,
            data: data
          ),
        ],
        animate: true,
        animationDuration: Duration(seconds: 1),
      ),
    );
  }

}
