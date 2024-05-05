import 'dart:io';
import 'package:monitoring_app/app_theme.dart';
import 'package:monitoring_app/monitoring_app/RegisterLogin/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_home_screen.dart';
import 'package:monitoring_app/monitoring_app/my_screen/product_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAez8XuFt5JnfVAwYB9vN3OehyulMFKh6c',
      authDomain: 'flutter-v1-42b4d.firebaseapp.com',
      projectId: 'flutter-v1-42b4d',
      storageBucket: 'flutter-v1-42b4d.appspot.com',
      messagingSenderId: '1088938898559',
      appId: '1:1088938898559:web:flutter-v1-42b4d',
      databaseURL:
          'https://flutter-v1-42b4d-default-rtdb.asia-southeast1.firebasedatabase.app/',
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'MonitoringAppV2.1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: const LoginScreen(),
      // MonitoringAppHomeScreen(),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
