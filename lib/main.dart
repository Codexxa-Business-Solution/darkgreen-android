import 'dart:async';

import 'package:darkgreen/LoginRegistation/login_screen.dart';
import 'package:darkgreen/constant/size_config.dart';
import 'package:darkgreen/presentation/darkgreen_dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DarkGreen',
      home:  MyHomePage(),
      debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/userLoginScreen': (BuildContext context) => const LoginScreen(),
          '/homeScreen': (BuildContext context) => const Dashboard(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // Future.delayed(Duration(seconds: 0)).then((_) {
    //   showModalBottomSheet(
    //       context: context,
    //       backgroundColor: Colors.transparent,
    //       elevation: 0,
    //       isScrollControlled: true,
    //       isDismissible: false,
    //       enableDrag: true,
    //       builder: (BuildContext bc) {
    //         return LoginScreen();
    //       });
    // });
    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.screenBottom),
      child:  Scaffold(
        backgroundColor: Colors.white,
        body: splash(SizeConfig.screenHeight, SizeConfig.screenWidth),
      ),
    );
  }

  Widget splash(double parentHeight, double parentWidth) {
    return const Center(
        child: Image(image: AssetImage("assets/images/welcome.gif")));
  }


  void navigateParentPage() {
    Navigator.of(context).pushReplacementNamed('/userLoginScreen');
  }

  void navigateHomePage() {
    Navigator.of(context).pushReplacementNamed('/homeScreen');
  }

  startTimer() async {
    var durtaion = const Duration(seconds: 2);

    try {

      // if (accessToken == null) {
         Timer(durtaion, navigateParentPage);
      // } else if (accessToken != null) {
      //   return Timer(durtaion, navigateHomePage);
      // }
    } catch (e) {
      print("eeeeeeee  $e");
    }
    return Timer(durtaion, navigateParentPage);
  }

}
