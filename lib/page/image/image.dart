import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../widget/mini_list_item.dart';

class MyImage extends StatelessWidget {
  const MyImage({Key? key, this.title, this.image, this.description, this.ingredients, this.preparation, this.rating, this.tags}) : super(key: key);

  final image;
  final title;
  final description;
  final ingredients;
  final preparation;
  final rating;
  final tags;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        body: _scrollImage(image, title, description, ingredients, preparation, rating, tags));

  }


  Widget _scrollImage(String image, String title, String description, List ingredients, List preparation, int rating, List tags) {
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
      }, body: SingleChildScrollView(child: Column(children: [
      Container(
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
                          for (var i = 0; i < rating; i++)
                            Lottie.asset("assets/star.json", height: 65, width: 65),

                        ]))])))),
      Container(
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
                            Row(children: [
                            MiniListItem(
                                text: ingredients != null &&
                                    ingredients[i] != null
                                    ? ingredients[i]
                                    : '')]

                            )]))
                  ])))),
      Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  color: const Color(0xfffafafa),
                  child: description != null
                      ? Container(
                    child: Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                      : Text('')))),
      description != null
          ? Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  color: const Color(0xfffafafa),
                  child: Text(description))))
          : Container(),
      Container(
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
                          for (var i = 0; i < preparation.length; i++)
                            Row(children: [
                              Text(preparation[i])
                            ],)
                        ]))
                  ])))),
      Container(
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
                          for (var i = 0; i < tags.length; i++)
                            Row(children: [
                              Text(tags[i])
                            ],)
                        ]))
                  ]))))


    ]))
    );}
}
