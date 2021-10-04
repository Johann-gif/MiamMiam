import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Favoris extends StatelessWidget {
  const Favoris({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Miam\'Miam',
        style: GoogleFonts.courgette(
          color: CupertinoColors.black,
          fontSize: 25,
        )),
    centerTitle: true,
    backgroundColor: Colors.white,
    ),
      body: Center(
        child: ElevatedButton(
          // Within the SecondScreen widget
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}