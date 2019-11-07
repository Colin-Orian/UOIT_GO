class Course{
  String courseId;
  String courseName;

  String time;

  Course(this.courseId,this.courseName){
    //TODO pull time from database
    //  Suggest To put weekdays
    this.time = DateTime.now().toLocal().toString().split(' ')[0];    
  }
  
  @override
  String toString(){
    return "${this.courseId}:${this.courseName}@${this.time}";
  }
}