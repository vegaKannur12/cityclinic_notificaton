import 'dart:convert';
import 'dart:io';
import 'package:cityclinicnotification/home_page.dart';
import 'package:cityclinicnotification/login.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:windows_single_instance/windows_single_instance.dart';

String? brName;
String? hstName;

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  // await windowManager.ensureInitialized();
// Add in main method.

  // WindowOptions windowOptions = WindowOptions(
  //   size: Size(600, 300),
  //   center: true,
  //   backgroundColor: Colors.transparent,
  //   skipTaskbar: false,
  //   titleBarStyle: TitleBarStyle.hidden,
  // );
  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   await windowManager.show();
  // });
  /////hostname/////////
  await getApitest();

  await WindowsSingleInstance.ensureSingleInstance(args, "custom_identifier",
      onSecondWindow: (args) {
    print("args----$args");
  });
  runApp(
    const MyApp(),
  );
}

getApitest() async {
  final File file = File('C:/flu/branch.txt');
  var text = await file.readAsString();
  String hostname = Platform.localHostname;
  Map body = {"branch_id": text, "sys_name": hostname};
  Uri url = Uri.parse("http://192.168.18.168/clinic2/API/notification_api.php");
  http.Response response = await http.post(url, body: body);
  var map = jsonDecode(response.body);
  brName = map["title"];
  hstName = Platform.localHostname;
  await localNotifier.setup(
    appName: brName.toString(),
    // The parameter shortcutPolicy only works on Windows
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );
  print("map---$map");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  // }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (AppLifecycleState.resumed == state) {
  //     Eraser.clearAllAppNotifications();
  //   }
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(49, 39, 79, 1),
        secondaryHeaderColor: const Color.fromARGB(255, 230, 158, 243),
        // primaryColor: Colors.red[400],
        // accentColor: Color.fromARGB(255, 248, 137, 137),
        scaffoldBackgroundColor: Colors.white,
        // fontFamily: 'Roboto Mono sample',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme: GoogleFonts.aBeeZeeTextTheme()
        // scaffoldBackgroundColor: P_Settings.bodycolor,
        // textTheme: const TextTheme(
        //   headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(
        //     fontSize: 25.0,
        //   ),
        //   bodyText2: TextStyle(
        //     fontSize: 14.0,
        //   ),
        // ),
      ),

      // home: OpenFileTest(),
      // home:PrintTest() ,
      // home: FileList(),
      // home: FileListComputer(),
      home: HomePage(brName: brName.toString(), sysName: hstName.toString()),
      // home: Login(),
    );
  }
}
