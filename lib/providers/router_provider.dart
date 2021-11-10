import 'package:flutter/material.dart';
import 'package:mobile/screens/mobile/splash_screen.dart';
import 'package:mobile/screens/native/main_screen.dart';
import 'package:mobile/screens/native/player_list_screen.dart';
import 'package:mobile/utils/constants.dart';

class RouterProvider {
  static getRoutes() {
    return <String, WidgetBuilder>{
      Constants.route_splash: (context) => SplashScreen(),
      Constants.route_wmain: (context) => NMainScreen(),
      Constants.route_wplay_list: (context) => NPlayerListScreen(),
      // Constants.route_onboard: (context) => OnBoardScreen(),
      // Constants.route_main: (context) => MainScreen(),
    };
  }
}
