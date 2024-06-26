import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messagingapp/API/api.dart';
import 'package:messagingapp/presentations/homepage.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../helper/dialog.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      setState(() {
        _isAnimate = true;
      });
    });
  }
  _handleGoogleBtnClick(){
    //for showing progressbar
    Dialogs.showProgressBar(context);
  _signInWithGoogle().then((user)async {
    //for hiding progressbar
    Navigator.pop(context);
    if(user != null) {
      print('\n User: ${user.user}');
      print('\n UserAdditionaInfo: ${user.additionalUserInfo}');
      if((await Apis.userExists())){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const HomeScreen()));
      }else{
        await Apis.createUser().then((value){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomeScreen()));
        });
      }

    }


  });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try{
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await Apis.auth.signInWithCredential(credential);
    }catch(e){
      print('_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'Something went wrong (Check Internet!)');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcome to TalksIndia"),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
              top: mq.height * .15,
              right: _isAnimate? mq.width * .3: -mq.width * .5,
              width: mq.width * .4,
              child: Image.asset("assets/images/logo.png")
          ),
          Positioned(
              bottom: mq.height * .1,
              left: mq.width * .09,
              height: mq.height * .05,
              width: mq.width * .8,
              child: SignInButton(Buttons.google, onPressed: (){
                _handleGoogleBtnClick();
              }),
              // child: ElevatedButton.icon(
              //     style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.greenAccent,
              //         shape: const StadiumBorder(),
              //         elevation: 1),
              //     onPressed: () {
              //       _handleGoogleBtnClick();
              //       //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              //       //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
              //     },
              //     icon: const Icon(Icons.ac_unit),
              //     label: const Text("Google"))
          ),
        ],
      ),
    );
  }
}
