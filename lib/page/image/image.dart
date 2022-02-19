import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
                          for (var i = 0; i < tags.length; i++)
                            Column(children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Colors.orange),
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(8),
                                  child: Text(tags[i],style: GoogleFonts.mochiyPopOne(
                                    fontSize: 12,
                                  color: Colors.white)))
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
                          Container(

                            child: Text(
                              'Ingredients',
                              style: GoogleFonts.mochiyPopOne(
                                color: Colors.orange,
                                fontSize: 18,
                              ),
                            ),
                          ),
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
                  padding: const EdgeInsets.only(left: 22, right: 30),
                  color: const Color(0xfffafafa),
                  child: description != null
                      ? Container(

                    child: Text(
                      'Description',
                      style: GoogleFonts.mochiyPopOne(
                        color: Colors.orange,
                        fontSize: 18,
                      ),
                    ),
                  )
                      : Text('')))),
      description != null
          ? Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  color: const Color(0xfffafafa),
                  child: Text(description, style: GoogleFonts.mochiyPopOne(
                      fontSize: 12)))))
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
                          Container(

                            child: Text(
                              'Preparation',
                              style: GoogleFonts.mochiyPopOne(
                                color: Colors.orange,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          for (var i = 0; i < preparation.length; i++)
                            Row(children: [
                              Container(
                                  padding: EdgeInsets.all(8),
                              child: Text(preparation[i],style: GoogleFonts.mochiyPopOne(
                                fontSize: 12,)))
                            ],)
                        ]))
                  ])))),


    ]))
    );}
}
