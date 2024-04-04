import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messagingapp/API/api.dart';
import 'package:messagingapp/presentations/auth/loginScreen.dart';
import 'package:messagingapp/presentations/homepage.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent,statusBarColor: Colors.white)
        //const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
      );
      if(Apis.auth.currentUser!=null) {
        print('\n User: ${Apis.auth.currentUser}');
        //navigate to Home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }else{
        //navigate to Login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }

    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  //   Future.delayed(const Duration(seconds: 2), () {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (_) => const LoginScreen(),
  //       ),
  //     );
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .15,
              right: mq.width * .3,
              width: mq.width * .4,
              child: Image.asset("assets/images/logo.png")
          ),
          Positioned(
              bottom: mq.height * .1,
              height: mq.height * .05,
              width: mq.width,
              child: const Text(
                "MADE IN INDIA WITH ❤️",
                style: TextStyle(color: Colors.black87, fontSize: 16),
                textAlign: TextAlign.center,
              )
          )
        ],
      ),
    );
  }
}
