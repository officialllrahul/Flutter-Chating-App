import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../Config/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsImage.appIcon,
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              Text(
                "TalkIndia",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 50),
              Text("Now you are", style: Theme.of(context).textTheme.headlineMedium),
              Text("Connected", style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(height: 30),
              Text(
                "Perfect solution of connect with anyone easily \nand more secure",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SlideAction(
                text: "Slide to start now",
                textStyle: Theme.of(context).textTheme.labelLarge,
                sliderRotate: false,
                submittedIcon: Icon(Icons.check),
                innerColor: Theme.of(context).colorScheme.primary,
                outerColor: Theme.of(context).colorScheme.primaryContainer,
                onSubmit: () {
                  Get.offAllNamed("/loginScreen");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
