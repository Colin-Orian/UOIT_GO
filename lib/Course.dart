
import 'package:flutter/material.dart';

class Course{
  String courseId;
  String courseName;
  double grade;
  String time;

  Course(this.courseId,this.courseName,this.grade){
    //TODO pull time from database
    //  Suggest To put weekdays
    this.time = "Wed";    
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