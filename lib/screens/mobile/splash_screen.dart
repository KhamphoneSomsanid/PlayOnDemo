import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/providers/navigator_provider.dart';
import 'package:mobile/screens/mobile/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      NavigatorProvider.of(context).pushToWidget(screen: MainScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/logo_nba.svg',
              height: 200.0,
            ),
            SizedBox(
              width: 40.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/img_logo.svg',
                  height: 120.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                SvgPicture.asset(
                  'assets/images/img_logo_label.svg',
                  height: 30.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
