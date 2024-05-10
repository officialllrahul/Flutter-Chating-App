import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Config/images.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsImage.appIcon,
                width: 100,
                height: 100,
              ),
              Text("TalkIndia",style: Theme.of(context).textTheme.headlineLarge)
            ],
          ),
        ),
      ),
    );
  }
}
