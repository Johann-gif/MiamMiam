import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:miammiam/data/models/recepe_model.dart';
import '../image/image.dart';

class Carroussel extends StatefulWidget {
  final List<RecepeModel> recettes;
  final double ratio;
  final bool enlarge;
  final double fraction;
  final bool autoPlay;
  final bool infinite;
  final double fontSize;
  final int initial;

  Carroussel({required this.recettes, this.ratio = 3.0, this.enlarge = false, this.fraction = 0.5, this.autoPlay = false, this.infinite = false, this.fontSize = 10.0, this.initial = 10});

  @override
  _CarrousselState createState() => _CarrousselState();
}

class _CarrousselState extends State<Carroussel> {
  //int _currentIndex = 0;
  List cardList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var recette in widget.recettes) {
      cardList.add(Item(recette: recette, fontSize: widget.fontSize));
    }
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        options: CarouselOptions(
          autoPlay: widget.autoPlay,
          autoPlayInterval: Duration(seconds: 7),
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          enlargeCenterPage: widget.enlarge,
          pageSnapping: true,
          aspectRatio: widget.ratio,
          initialPage: widget.initial,
          viewportFraction: widget.fraction,
          enableInfiniteScroll: widget.infinite,
        ),
        items: cardList.map((card) {
          return Builder(builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: card,
              ),
            );
          });
        }).toList(),
      ),
    ]);
  }
}

class Item extends StatelessWidget {
  final RecepeModel recette;
  final double fontSize;

  Item({required this.recette, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: NetworkImage(
                      recette.image_url!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyImage(title: recette.title, image: recette.image_url, description: recette.description, ingredients: recette.ingredients, preparation: recette.preparation, rating: recette.rating, tags: recette.tags)));
            },
          ),
          Container(
              child: Column(children: [
            /*Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.orange,
                    )),
              ),
            ),*/
            Expanded(child: Container(), flex: 8),
            Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15), topLeft: Radius.zero, topRight: Radius.zero),color: Colors.white.withOpacity(0.7),),
                child: Padding(
                    padding: EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Center(
                      child: Text(recette.title!,
                          style: GoogleFonts.roboto(
                            color: CupertinoColors.black,
                            fontSize: fontSize,
                          )),
                    ))),
          ]))
        ]));
  }
}
