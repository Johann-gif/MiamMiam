import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:miammiam/data/models/recepe_model.dart';

import '../../widget/mini_list_item.dart';

class MyImage extends StatefulWidget {
  const MyImage({Key? key, this.recette}) : super(key: key);
  final recette;


  @override
  State<MyImage> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  late final Box box;
  bool _isLikeOn = false;

  _deleteFavoris(int index) async {
    var listRecepe = [];
    for (int i=0;i<box.length;i++){
      if (i == index) {
      } else listRecepe.add(box.getAt(i));
    }
    await box.clear();
    for (int j=0;j<listRecepe.length;j++){
      await box.add(listRecepe[j]);
    }
  }

  _addFavoris(RecepeModel recepe) {
    box.add(recepe);
  }

  _getAddDelete(RecepeModel recepe) async {
    if (_isLikeOn == true) {
      await _addFavoris(recepe);
    } else {
      for (var i = 0; i < box.length; i++) {
        if (recepe.title == box.getAt(i).title) {
          await _deleteFavoris(i);
        }
      }
    }
  }

  _getFavoriteStatus(RecepeModel recepe) {
    for (var i = 0; i < box.length; i++) {
      if (widget.recette.title == box.getAt(i).title) {
        setState(() {
          _isLikeOn = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        body: _scrollImage(widget.recette));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box('favorites');
    _getFavoriteStatus(widget.recette);
  }

  Widget _scrollImage(RecepeModel recepe) {
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
                title: Text(recepe.title!, style: TextStyle(color: Colors.white),
                ),
                background: Image.network(
                  recepe.image_url!,
                  fit: BoxFit.cover,
                )),
          ),

        ];
      }, body: SingleChildScrollView(child: Column(children: [
      IconButton(
        padding: const EdgeInsets.only(
            left: 0, top: 5.0, right: 20.0, bottom: 5.0),
        icon: Icon(
          _isLikeOn == true
              ? Icons.favorite
              : Icons.favorite_border,
          color: Colors.orange,
        ),
        onPressed: () {
          setState(() {
            _isLikeOn = !_isLikeOn;
          });
          _getAddDelete(recepe);
          final snackBar = SnackBar(
            content: _isLikeOn == true
                ? Text('Vous avez ajouté ' +
                recepe.title.toString() +
                ' à vos favoris.')
                : Text('Vous avez retiré ' +
                recepe.title.toString() +
                ' de vos favoris.'),
            action: SnackBarAction(
              label: 'Annuler',
              onPressed: () {
                setState(() {
                  _isLikeOn = !_isLikeOn;
                });
                _getAddDelete(recepe);
                final snackBar = SnackBar(
                    content: _isLikeOn == true
                        ? Text(recepe.title.toString() +
                        ' a été rajouté à vos favoris.')
                        : Text(recepe.title.toString() +
                        ' a été retiré de vos favoris.'));
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar);
              },
            ),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        },
      ),
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
                        child: Wrap(spacing: 0,children: [
                          for (var i = 0; i < recepe.rating!; i++)
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
                          for (var i = 0; i < recepe.tags!.length; i++)
                            Column(children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Colors.orange),
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(8),
                                  child: Text(recepe.tags![i],style: GoogleFonts.mochiyPopOne(
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
                          for (var i = 0; i < recepe.ingredients!.length; i++)
                            Row(children: [
                            MiniListItem(
                                text: recepe.ingredients! != null &&
                                    recepe.ingredients![i] != null
                                    ? recepe.ingredients![i]
                                    : '')]

                            )]))
                  ])))),
      Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.only(left: 22, right: 30),
                  color: const Color(0xfffafafa),
                  child: recepe.description != null
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
      recepe.description != null
          ? Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  color: const Color(0xfffafafa),
                  child: Text(recepe.description!, style: GoogleFonts.mochiyPopOne(
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
                          for (var i = 0; i < recepe.preparation!.length; i++)
                            Row(children: [
                              Container(
                                  padding: EdgeInsets.all(8),
                              child: Text(recepe.preparation![i],style: GoogleFonts.mochiyPopOne(
                                fontSize: 12,)))
                            ],)
                        ]))
                  ])))),


    ]))
    );}
}
