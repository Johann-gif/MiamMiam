import 'package:flutter/material.dart';

import '../main.dart';
import 'myHomePage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2500), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
              title: 'GFG',
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo2.png', height: 200),
              Text('MiamMiam',
                  style: TextStyle(
                      fontSize: 30,
                      color: const Color(0xff37718E),
                      fontWeight: FontWeight.bold)),
            ],
          )
      ),
    );
  }
}
