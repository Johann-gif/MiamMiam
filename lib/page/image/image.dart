import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widget/mini_list_item.dart';

class MyImage extends StatelessWidget {
  const MyImage({Key? key, this.title, this.image, this.description, this.ingredients}) : super(key: key);

  final image;
  final title;
  final description;
  final ingredients;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        body: _scrollImage(image, title, description, ingredients));

  }


  Widget _scrollImage(String image, String title, String description, List ingredients) {
    //Plein écran lors de l'affichage de la fenêtre
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            foregroundColor: Colors.black,
            expandedHeight: MediaQuery.of(context).size.height / 2,
            backgroundColor: Colors.transparent,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                //titlePadding: EdgeInsetsDirectional.all(0),
                title: Text(title, style: TextStyle(color: Colors.white),
                ),
                background: Image.network(
                  image,
                  fit: BoxFit.cover,
                )),
          ),

        ];
      }, body: Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                color: const Color(0xfffafafa),
                child: Column(children: [
                  Container(
                      margin: const EdgeInsets.only(
                          top: 20, left: 22, right: 22),
                      child: Wrap(children: [
                        for (var i = 0; i < ingredients.length; i++)
                          MiniListItem(
                              text: ingredients != null &&
                                  ingredients[i] != null
                                  ? ingredients[i]
                                  : '')
                      ]))
                ])))),);
  }
}
