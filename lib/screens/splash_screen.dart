import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/screens/intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final FirebaseMessaging fcm = FirebaseMessaging();
    if (Platform.isIOS) {
      // 권한이 설정되지 않았으면 요청하는 창을 띄움
      fcm.requestNotificationPermissions(
          IosNotificationSettings(sound: true, badge: true, alert: true));
      fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });
    }
    fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    });

    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (context) => new IntroScreen()))); //checkFirstSeen());
  }

  // Future checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _seen = (prefs.getBool('seen') ?? false);

  //   if (_seen) {
  //     Navigator.of(context).pushReplacement(
  //         new MaterialPageRoute(builder: (context) => new RootPage()));
  //   } else {
  //     await prefs.setBool('seen', true);
  //     Navigator.of(context).pushReplacement(
  //         new MaterialPageRoute(builder: (context) => new IntroScreen()));
  //   }
  //}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/images/splash.png'),
    );
  }
}
