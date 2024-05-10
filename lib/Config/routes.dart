import 'package:get/get.dart';
import 'package:talkindia/Presentations/login_screen/login_screen.dart';

var routes = [
  GetPage(
  name: "/loginScreen",
    page: ()=> LoginScreen(),
    transition: Transition.rightToLeft
  )
];