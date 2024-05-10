import 'package:flutter/material.dart';
import 'package:talkindia/Config/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkindia/Presentations/landing_screen/landing_screen.dart';

import '../login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LandingScreen(),
        ),
      );
    });
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsImage.appIcon,
              width: 100,
              height: 100,
            ),
            Text("TalkIndia",style: Theme.of(context).textTheme.headlineLarge)
          ],
        )
      ),
    );
  }
}
