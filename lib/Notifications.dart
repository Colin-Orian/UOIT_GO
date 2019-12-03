import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications{
    var _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    final channelId = 'locationChange';
    final channelName = 'Location Change';
    final channelDesc = 'Used when there is a change to the location';
    NotificationDetails _platformChannelInfo;
    var notificationId = 100;

    Future onSelection(var payload) async{

    }
    void init(){
      var android = new AndroidInitializationSettings('mipmap/ic_launcher');

      var ios = new IOSInitializationSettings(
        onDidReceiveLocalNotification: (int id, String title, String body, String payload) { return null; }
      );

      var initializationSettings = new InitializationSettings(android, ios);
      _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelection);

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

    Future<void> sendNotification(String title, String body, String payload) async{
      if(this._platformChannelInfo == null){
        print("null");
      }
      _flutterLocalNotificationsPlugin.show(notificationId, title, body, this._platformChannelInfo, payload: payload);
      print('sent notification');
    }
}