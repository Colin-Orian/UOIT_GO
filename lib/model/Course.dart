import 'package:flutter/material.dart';

class Course{
  int id;
  String courseId;
  String courseName;
  double grade;
  bool passed;
  String time;

  Course(this.courseId,this.courseName,this.grade){
    this.time = "Wed";    
    if (grade>=50){
      passed = true;
    }else{
      passed = false;
    }
  }
  
  Course.fromMap(Map<String,dynamic> map){
    this.id = map["id"];
    this.courseId = map["courseId"];
    this.courseName = map["courseName"];
    this.grade = map["grade"];
    if (this.grade>=50){
      passed = true;
    }else{
      passed = false;
    }
    this.time = "WED";
  }

  Map<String,dynamic> toMap(){
    return {
      "id":this.id,
      "courseId":this.courseId,
      "courseName":this.courseName,
      "grade":this.grade,
    };
  }

  int getID(){
    return this.id;
  }

  int getColorValue(){
    int color = (9*this.grade/100).floor()*100;
    return 900-color;
  }

  Color getColor(){
    if(this.grade < 50){
      return Colors.red[this.getColorValue()];
    }else if(this.grade>=50 && this.grade < 75){
      return Colors.amber[this.getColorValue()];
    }else if(this.grade>=75 && this.grade < 90){
      return Colors.blue[this.getColorValue()];
    }
    return Colors.green;
  } 
  
  @override
  String toString(){
    return "${this.courseId}:${this.courseName}@${this.time} - ${this.grade}%";
  }
}