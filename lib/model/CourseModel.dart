import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'db_utils.dart';
import 'Course.dart';

class CourseModel{
  Future<int> insertCourse(Course course) async {
    final db = await DBUtils.init();
    return await db.insert(
      'courses',
      course.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateCourse(Course course) async{
    final db = await DBUtils.init();
    return await db.update(
      'courses',
      course.toMap(),
      where: 'id = ?',
      whereArgs: [course.getID()],
    );
  }

  Future<int> deleteCourse(Course course) async{
    final db = await DBUtils.init();
    return await db.delete(
      'courses',
      where: 'id = ?',
      whereArgs: [course.getID()],
    );
  }

  Future<List<Course>> getAllCourses() async {
    final db = await DBUtils.init();
    List<Map<String,dynamic>> maps = await db.query('courses');
    List<Course> courses = [];
    for (int i=0;i<maps.length;i++){
      print(Course.fromMap(maps[i]).toString());
      courses.add(Course.fromMap(maps[i]));
    }
    return courses;
  }

  Future<Course> getCourseByName(String name)async {
    final db = await DBUtils.init();
    List<Map<String, dynamic>> maps = await db.query('courses',
      where: 'courseName=?',
      whereArgs: [name]);
    if(maps.length > 0){
      return Course.fromMap(maps[0]);
    }
    return null;
  }
}