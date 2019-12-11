import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'Course.dart';
import 'package:flip_card/flip_card.dart';
import 'GraduationPage.dart';
import 'AddCourse.dart';

class AcademicPage extends StatefulWidget{
  BuildContext context;
  final String title;
  AcademicPage({Key key,this.title,this.context});

  @override
  AcademicPageState createState() => AcademicPageState(context);
}

class AcademicPageState extends State<AcademicPage>{
  BuildContext context;
  List builds;
  Course newCourse;

  List<Course> courses = <Course>[
    Course("CSCI 4100U","Mobile Development",95.0),
    Course("CSCI 3055U","Programming Language",63.0),
    Course("CSCI 2070U","Computational Sci.",50.0),
    Course("CSCI 4620U","HCI",80.0),
    Course("CSCI 4000U","Adv. Computer Japhics",34.0),
    Course("CSCI 3020U","Operating Systems",17.0),
  ];


  AcademicPageState(BuildContext context){
    this.context =context;
    if(mounted){
      setState(() {
        
      });
    }else{
      builds = <Widget>[];
    }
  }
  @override
  Widget build(BuildContext context) {
    // builds = courses.map((course)=>_buildCoures(course)).toList();
    return Scaffold( 
        floatingActionButton: FloatingActionButton(
          child:  Icon(Icons.add),
          onPressed: (){
            setState(() {
              _addCourse();
            });
          },
        ),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child:_buildGradeProgressBtn(),
          ),
          Flexible(
            child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: List.generate(courses.length, 
                    (int index){
                      return _buildCoures(courses[index], index);
                    }),
                ),
            ),
          
        ],
      )
    );
  }
  Future<Course> _addCourse() async{
    this.newCourse = await 
      Navigator.push( context, 
                      MaterialPageRoute(builder: (context)=>AddCoursePage()));
    setState(() {
      if (this.newCourse!=null){
        print("coures: $newCourse");
        courses.add(newCourse);  
      }
    });
    print(builds);
            
    return newCourse;
  }

  // Build each course card

  Container _buildCoures(Course course, index){
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
      /*
        Flip Card
      */
      child: FlipCard(
        direction: FlipDirection.VERTICAL,
        front: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:10.0),
                    child: CircleAvatar(
                      child: Icon(
                          Icons.edit,
                          size: 24.0,
                        ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical:20.0),
                    width: 0.5 * MediaQuery.of(context).size.width,
                    height: 0.1 * MediaQuery.of(context).size.height,
                    child: Text(course.courseName,style: TextStyle(
                      fontSize: 18.0,
                      color: textColorFront,
                      ),
                    )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
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
                child:Text(FlutterI18n.translate(
                  context,
                  "Academic.tap"
                ),textAlign: TextAlign.center,style: TextStyle(
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
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: (){
                        setState(() {
                          courses.removeAt(index);
                        }); 
                      },
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

  Widget _buildGradeProgressBtn(){
    //TODO From Database
    List<Course> courseList = courses;
    int passedNum = 0;
    for (int i=0;i<courseList.length;i++){
      if(courseList[i].passed)
        passedNum++;
    } 
    double progress = (passedNum / courseList.length);  

    return GestureDetector(
      onTap:(){
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>GraduationPage())
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black38,offset: Offset(0, 2.0),blurRadius: 2.0)
            ],
        ),
        child: Card(
          child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal:15.0,vertical:10.0),
                  child: Row(
                    children: <Widget>[
                      Text(FlutterI18n.translate(
                        context,
                        "Academic.check"
                      )),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: (){
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>GraduationPage(courses: courses,))
                            );
                          });
                        },
                      ), 
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:15.0,vertical:10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //graduation progress bar
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width-130,
                          alignment: MainAxisAlignment.end,
                          center: Text(
                            (progress*100).toStringAsFixed(2)+"%",
                            style: TextStyle(color: Colors.black),
                            ),
                          leading: Text(FlutterI18n.translate(
                            context,
                            "Academic.graduation"
                          ),
                          style: TextStyle(color: Colors.black),
                          ),
                          lineHeight: MediaQuery.of(context).size.height*0.03,
                          percent: progress,
                          progressColor: Colors.green,
                        )],
                      )
                    ),
                  ],
                )
              ],
          ),
        ),
      ),
    );
  }
}