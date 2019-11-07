import 'dart:math';

import 'package:flutter/material.dart';
import 'Course.dart';

class AcademicPage extends StatefulWidget{
  final String title;
  AcademicPage({Key key,this.title});

  @override
  AcademicPageState createState() => AcademicPageState();
}

class AcademicPageState extends State<AcademicPage>{
  int index=0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        children: <Widget>[
          _buildCoures(Course("CSCI 4100U","Mobile Development"),index++),
          _buildCoures(Course("CSCI 4100U","Mobile Development"),index++),
          _buildCoures(Course("CSCI 4100U","Mobile Development"),index++),
          _buildCoures(Course("CSCI 4100U","Mobile Development"),index++),
          _buildCoures(Course("CSCI 4100U","Mobile Development"),index++),
        ],
      ),
    );
  }
  Card _buildCoures(Course course,int index){
    return Card(
      color: Colors.blue[100*index],
      margin: EdgeInsets.symmetric(vertical: 5.0),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal:10.0,vertical:20.0),
            child: Text(course.courseName,textAlign: TextAlign.center,style: TextStyle(
              fontSize: 18.0
            ),)
          ),
          Padding(
            //color: Colors.amber,
            padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text(course.courseId,textAlign: TextAlign.center,)
                ),
                Container(
                  child:  Text(course.time,textAlign: TextAlign.center,)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  } 
}
