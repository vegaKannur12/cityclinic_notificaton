import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eraser/eraser.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:http/http.dart' as http;
import 'package:windows_notification/windows_notification.dart';

class HomePage extends StatefulWidget {
  String brName;
  String sysName;
  HomePage({required this.brName, required this.sysName});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool status = false;
  dynamic _winNotifyPlugin;
  TextEditingController user = TextEditingController();
  TextEditingController pwd = TextEditingController();

  @override
  void initState() {
    // getApitest();
    // _winNotifyPlugin = WindowsNotification(applicationId: "qweqwe");

    // _winNotifyPlugin
    //     .initNotificationCallBack((notification, status, argruments) {
    //   print("aargs: $argruments");
    // });
    getbr();

    super.initState();
  }

  // localnot(String title, String body, String type) {
  //   LocalNotification notification = LocalNotification(
  //     title: title,
  //     body: body,
  //     // subtitle: "sjjdbhjfb"
  //   );
  //   notification.onShow = () {
  //     print('onShow ${notification.identifier}');
  //   };
  //   // notification.close();
  //   notification.onClose = (closeReason) {
  //     // Only supported on windows, other platforms closeReason is always unknown.
  //     switch (closeReason) {
  //       case LocalNotificationCloseReason.userCanceled:
  //         // do something
  //         break;
  //       // case LocalNotificationCloseReason.timedOut:
  //       //   // do something
  //       //   break;
  //       default:
  //     }
  //     print('onClose ${notification.identifier} - $closeReason');
  //   };
  //   notification.onClick = () {
  //     print("kjcjhjdhjc");
  //     print('onClick ${notification.identifier}');
  //   };
  //   // notification?.onClickAction = (actionIndex) {
  //   //   print('onClickAction ${notification.identifier} - $actionIndex');
  //   // };

  //   notification.show();
  // }

  getbr() async {
    final File file = File('C:/flu/branch.txt');
    var text = await file.readAsString();
    timerTest(text);
    print('File Contents\n---------------$text');
  }

  sendWithPluginTemplate(dynamic body, String caption, String type) {
    NotificationMessage message = NotificationMessage.fromPluginTemplate(
      "test1", caption, body.toString(),
      group: "dzjhsfh", image: "file:///C:/flu/not$type.png",
      // launch: "http://vegasoft.in/"
    );
    _winNotifyPlugin.showNotificationPluginTemplate(
      message,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.green[600],
          title: Text(
            "City Clinic Notification Manager",
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                  onTap: () {
                    windowManager.minimize();
                  },
                  child: Icon(Icons.remove)),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 0.3,
                    child: Text(
                      "Branch Name",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]),
                    ),
                  ),
                  Text(":"),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Expanded(
                    child: Text(
                      widget.brName.toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 0.3,
                    child: Text(
                      "System Name",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]),
                    ),
                  ),
                  Text(":"),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Expanded(
                    child: Text(
                      widget.sysName.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Image.file(
                File("C:/flu/not1.png"),
                height: 90,
              ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              // Container(
              //   height: size.height * 0.07,
              //   child: TextField(
              //     controller: user,
              //     decoration: InputDecoration(
              //       contentPadding: EdgeInsets.all(0),
              //       hintText: "Username",
              //        fillColor: Colors.white,filled: true,
              //       hintStyle: TextStyle(fontSize: 11),
              //       prefixIcon: Icon(Icons.person),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             width: 1, color: Colors.grey), //<-- SEE HERE
              //         borderRadius: BorderRadius.circular(50.0),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             width: 1, color: Colors.grey), //<-- SEE HERE
              //         borderRadius: BorderRadius.circular(50.0),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              // Container(
              //   height: size.height * 0.07,
              //   child: TextField(
              //     controller: pwd,
              //     decoration: InputDecoration(
              //       contentPadding: EdgeInsets.all(0),
              //       hintStyle: TextStyle(fontSize: 11),
              //       hintText: "Password",
              //        fillColor: Colors.white,filled: true,

              //       prefixIcon: Icon(Icons.password),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             width: 1, color: Colors.grey), //<-- SEE HERE
              //         borderRadius: BorderRadius.circular(50.0),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             width: 1, color: Colors.grey), //<-- SEE HERE
              //         borderRadius: BorderRadius.circular(50.0),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: size.height * 0.02,
              // ),
              // Container(
              //   width: size.width * 0.8,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(primary: Colors.red),
              //       onPressed: () async {
              //         final Uri url = Uri.parse('https://flutter.dev');
              //         if (!await launchUrl(url)) {
              //           throw Exception('Could not launch $url');
              //         }
              //         // var urllaunchable = await canLaunch(
              //         //     url); //canLaunch is from url_launcher package
              //         // if (urllaunchable) {
              //         //   await launch(
              //         //       url); //launch is from url_launcher package to launch URL
              //         // } else {
              //         //   print("URL can't be launched.");
              //         // }
              //       },
              //       child: Text("LOGIN")),
              // )
            ],
          ),
        ));
  }

  timerTest(String br) async {
    // Timer(Duration(seconds: 10), () {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      status = !status;
      getApitest(br);
      // Provider.of<Controller>(context, listen: false).getApi();
      // if (status) {
      //   sendWithPluginTemplate();
      // } else {

      // }
    });
    // });
  }

  getApitest(String brId) async {
    String hostname = Platform.localHostname;
    print("host----$hostname");
    Map body = {"branch_id": brId, "sys_name": hostname};
    print("body----$body");
    Uri url =
        Uri.parse("http://192.168.18.168/clinic2/API/notification_api.php");
    http.Response response = await http.post(url, body: body);
    var map = jsonDecode(response.body);
    print("map---$map");
    if (map != null) {
      // localnot(map["msg"], map["caption"], map["not_type"].toString());
      _winNotifyPlugin = WindowsNotification(applicationId: map["title"]);

      _winNotifyPlugin
          .initNotificationCallBack((notification, status, argruments) {
        print("aargs: $argruments");
      });
      await FlutterPlatformAlert.playAlertSound();
      sendWithPluginTemplate(
          map["msg"], map["caption"], map["not_type"].toString());
    }
    // sendMyOwnTemplate();
  }
}
