import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miammiam/data/models/recepe_model.dart';
import 'package:miammiam/page/accueil/caroussel.dart';
import 'package:miammiam/page/image/image.dart';
import '../global/loading.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final ScrollController _scrollController = ScrollController();
  final Stream<QuerySnapshot> _recepesStream =
      FirebaseFirestore.instance.collection('recepes').snapshots();
  CollectionReference recepes =
      FirebaseFirestore.instance.collection('recepes');
  bool initP = false;
  bool initE = false;
  bool initD = false;
  List<RecepeModel> plats = [];
  List<RecepeModel> entrees = [];
  List<RecepeModel> desserts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEntrees();
    getPlats();
    getDesserts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels +
              MediaQuery.of(context).size.height * 0.30 >=
          _scrollController.position.maxScrollExtent) {
        //TODO
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  void getEntrees() async {
    List<RecepeModel> list = [];
    final querySnapshot =
        await recepes.limit(5).where('tags', arrayContains: 'entree').get();
    for (var doc in querySnapshot.docs) {
      list.add(RecepeModel.fromMap(doc));
    }
    setState(() {
      entrees = list;
      initE = true;
    });
    //return list;
  }

  void getPlats() async {
    List<RecepeModel> list = [];
    final querySnapshot =
        await recepes.limit(5).where('tags', arrayContains: 'plat').get();
    for (var doc in querySnapshot.docs) {
      list.add(RecepeModel.fromMap(doc));
    }
    setState(() {
      plats = list;
      initP = true;
    });
    //return list;
  }

  void getDesserts() async {
    List<RecepeModel> list = [];
    final querySnapshot =
        await recepes.limit(5).where('tags', arrayContains: 'dessert').get();
    for (var doc in querySnapshot.docs) {
      list.add(RecepeModel.fromMap(doc));
    }
    setState(() {
      desserts = list;
      initD = true;
    });
    //return list;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView(
        controller: _scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Les ',
                    style: GoogleFonts.mochiyPopOne(
                      color: CupertinoColors.black,
                      fontSize: 15,
                    )),
                Text('entrées',
                    style: GoogleFonts.mochiyPopOne(
                      color: Colors.orange,
                      fontSize: 15,
                    ))
              ],
            ),
          ),
          initE
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Carroussel(
                      recettes: entrees,
                      ratio: 2.0,
                      enlarge: true,
                      fraction: 1,
                      autoPlay: true,
                      infinite: true,
                      fontSize: 15.0),
                )
              : Loading(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Les ',
                    style: GoogleFonts.mochiyPopOne(
                      color: CupertinoColors.black,
                      fontSize: 15,
                    )),
                Text('plats',
                    style: GoogleFonts.mochiyPopOne(
                      color: Colors.orange,
                      fontSize: 15,
                    ))
              ],
            ),
          ),
          initP
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Carroussel(
                      recettes: plats,
                      ratio: 2.0,
                      enlarge: true,
                      fraction: 1,
                      autoPlay: true,
                      infinite: true,
                      fontSize: 15.0),
                )
              : Loading(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Les ',
                    style: GoogleFonts.mochiyPopOne(
                      color: CupertinoColors.black,
                      fontSize: 15,
                    )),
                Text('desserts',
                    style: GoogleFonts.mochiyPopOne(
                      color: Colors.orange,
                      fontSize: 15,
                    ))
              ],
            ),
          ),
          initD
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Carroussel(
                      recettes: desserts,
                      ratio: 2.0,
                      enlarge: true,
                      fraction: 1,
                      autoPlay: true,
                      infinite: true,
                      fontSize: 15.0),
                )
              : Loading(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Toutes les ',
                    style: GoogleFonts.mochiyPopOne(
                      color: CupertinoColors.black,
                      fontSize: 15,
                    )),
                Text('recettes',
                    style: GoogleFonts.mochiyPopOne(
                      color: Colors.orange,
                      fontSize: 15,
                    ))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: _recepesStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Loading();
                    }

                    return GridView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]
                                              .get('image_url')),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => MyImage(recette: snapshot
                                                  .data!.docs[index])));
                                    },
                                  ),
                                  Container(
                                      child: Column(children: [
                                    Expanded(child: Container(), flex: 8),
                                    Container(
                                        width: double.infinity,
                                        height: 35,
                                        color: Colors.white.withOpacity(0.7),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 8.0, left: 8.0),
                                            child: Center(
                                                child: Text(
                                                    snapshot.data!.docs[index]
                                                        .get('title'),
                                                    style: GoogleFonts.roboto(
                                                      color:
                                                          CupertinoColors.black,
                                                      fontSize: 10,
                                                    ))))),
                                  ]))
                                ]),
                          );
                        });
                  }))
        ],
      ),
    ]);
  }
}
