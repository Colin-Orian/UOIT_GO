import 'package:flutter/material.dart';
import 'package:uoit_go/Course.dart';

class AddCoursePage extends StatefulWidget{
  AddCoursePage({Key key}):super(key:key);

  @override
  AddCoursePageState createState() => AddCoursePageState();
}


class AddCoursePageState extends State<AddCoursePage>{

  String courseName; 
  String courseId;
  double grade; 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Course"),
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Text("Coures Name:"),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Coures Name"
                  ),
                  onChanged: (val){
                    this.courseName = val;
                  },
                ),
              ),
            ],
          ),
          
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Text("Coures ID:"),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Coures Id"
                  ),
                  onChanged: (val){
                    this.courseId= val;
                  },
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Text("Inital Grade:"),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Grade"
                  ),
                  onChanged: (val){
                    this.grade = double.parse(val);
                  },
                ),
              ),
            ],
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: (){
          Course course = Course(this.courseId,this.courseName,this.grade);
          setState(() {
            Navigator.of(context).pop(course);
          });
        },
      ),
    );
  }

}