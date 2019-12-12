import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//This class hides initalizes the notifcation plugin and makes notifcations easier to run
//with the sendNotification() function
class Notifications{
    var _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    final channelId = 'locationChange';
    final channelName = 'Location Change';
    final channelDesc = 'Used when there is a change to the location';
    NotificationDetails _platformChannelInfo;
    var notificationId = 100;

    Future onSelection(var payload) async{

    }
    //Initalize the notification plugin by setting up the settings and the details for both android and iOS
    void init(){
      var android = new AndroidInitializationSettings('mipmap/ic_launcher'); //The icon used for the app

      var ios = new IOSInitializationSettings(
        onDidReceiveLocalNotification: (int id, String title, String body, String payload) { return null; }
      );

      var initializationSettings = new InitializationSettings(android, ios);
      _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelection);
      //android settings
      var androidPlatformChannelInfo = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDesc, 
        importance: Importance.High,
        priority: Priority.High, 
        ticker: 'ticker',
      );

      var iosPlatformChangeInfo = IOSNotificationDetails();
      this._platformChannelInfo = NotificationDetails(androidPlatformChannelInfo, iosPlatformChangeInfo);
    }

    /*Display the notification right after the function is called
    */
    Future<void> sendNotification(String title, String body, String payload) async{
      if(this._platformChannelInfo == null){
        print("null");
      }
      _flutterLocalNotificationsPlugin.show(notificationId, title, body, this._platformChannelInfo, payload: payload);
    }
}