import 'dart:math';

import 'package:flutter/material.dart';
import 'Course.dart';
import 'package:flip_card/flip_card.dart';

class AcademicPage extends StatefulWidget{
  final String title;
  AcademicPage({Key key,this.title});

  @override
  AcademicPageState createState() => AcademicPageState();
}

class AcademicPageState extends State<AcademicPage>{
  //test
  List courses = <Course>[
    Course("CSCI 4100U","Mobile Development",95.0),
    Course("CSCI 4100U","Mobile Development",63.0),
    Course("CSCI 4100U","Mobile Development",50.0),
    Course("CSCI 4100U","Mobile Development",75.0),
    Course("CSCI 4100U","Mobile Development",45.0),
    Course("CSCI 4100U","Mobile Development",72.0),
    Course("CSCI 4100U","Mobile Development",38.0),
    Course("CSCI 4100U","Mobile Development",72.0),
    Course("CSCI 4100U","Mobile Development",89.0),
  ];

  bool showOverall = false;

  @override
  Widget build(BuildContext context) {
    List builds = <Widget>[
            _buildCoures(courses[0]),
            _buildCoures(courses[1]),
            _buildCoures(courses[2]),
            _buildCoures(courses[3]),
            _buildCoures(courses[4]),
            _buildCoures(courses[5]),
            _buildCoures(courses[6]),
            _buildCoures(courses[7]),
            _buildCoures(courses[8]),
          ];
    List widgets = <Widget>[
      Container(
        child: Card(
          child: Row(
            children: <Widget>[
              Text("Show total grades"),
              Switch(
                value: showOverall,
                onChanged: (value){},
              ),
              ],
            ),
          ),
      )
    ];
    widgets.addAll(builds);
    return  ListView(
        children: widgets
      );
  }

  Container _buildCoures(Course course){
    Color backgroundColor = course.getColor();
    Color textColorFront = getTextColor(Colors.white);
    Color textColorBack = getTextColor(backgroundColor);
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black38,offset: Offset(0, 2.0),blurRadius: 2.0)
          ],
      ),
      margin: EdgeInsets.only(bottom: 5.0),
      child: FlipCard(
        direction: FlipDirection.VERTICAL,
        front: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:12.0),
                    child: CircleAvatar(
                      child: Icon(
                          Icons.edit,
                          size: 24.0,
                        ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:10.0,vertical:20.0),
                    child: Text(course.courseName,textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 18.0,
                      color: textColorFront,
                      ),
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Text(course.courseId,textAlign: TextAlign.center,style: TextStyle(
                              color: textColorFront,
                              ),
                            )
                        ),
                        Container(
                          child:  Text(course.time,textAlign: TextAlign.center,style: TextStyle(
                              color: textColorFront,
                            ),)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child:Text("Tap to see grade.",textAlign: TextAlign.center,style: TextStyle(
                    color: textColorFront,
                    fontSize: 12.0,
                ),)
              )
            ],
          ),
        ),
        back: Container(
          color: backgroundColor,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:10.0,vertical:20.0),
                    child: Text(course.courseName,textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 18.0,
                      color: textColorBack,
                      ),
                    )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:30.0,vertical:20.0),
                    child: Text("${course.grade.toString()}%",textAlign: TextAlign.center,style: TextStyle(
                        fontSize: 18.0,
                        color: textColorBack, 
                        ),
                      ),
                  )
                ]
              ),
              Container(
                child:Text("",textAlign: TextAlign.center,style: TextStyle(
                    color: textColorBack,
                    fontSize: 12.0,
                ),)
              )
            ],
          ),
        ),
      ),
    );
  } 

  Color getTextColor(Color background){
    int white = 0;
    double a1 = 0.299;
    double a2 = 0.587;
    double a3 = 0.114;

    double l = (a1*background.red + a2*background.green + a3*background.blue)/255.0;

    if(l>0.5)
      white=0;
    else
      white=255;

    return Color.fromARGB(255, white, white, white);
  }

}
