import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Recherche extends StatelessWidget {
  const Recherche({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text("Recherche")),
        Expanded(child: Lottie.asset("assets/food.json"))
      ],
    );
  }
}
