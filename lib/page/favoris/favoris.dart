import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import '../image/image.dart';

class Favoris extends StatefulWidget {
  @override
  State<Favoris> createState() => _FavorisState();
}

class _FavorisState extends State<Favoris> {

  late final Box box;

  _deleteFavoris(int index) async {
    var listFavori = [];
    for (int i=0;i<box.length;i++){
      if (i == index) {
      } else listFavori.add(box.getAt(i));
    }
    await box.clear();
    for (int j=0;j<listFavori.length;j++){
      await box.add(listFavori[j]);
    }
  }

  _deleteAllFavoris() {
    box.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box('favorites');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Vos recettes ',
                style: GoogleFonts.mochiyPopOne(
                  color: CupertinoColors.black,
                  fontSize: 15,
                )),
            Text('favorites',
                style: GoogleFonts.mochiyPopOne(
                  color: Colors.orange,
                  fontSize: 15,
                ))
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(5.0),
          child: ValueListenableBuilder(
              valueListenable: Hive.box('favorites').listenable(),
              builder: (context, Box box, _) {
                if (box.values.length == 0)
                  return Center(
                    child: Text("Aucun favoris"),
                  );
                return GridView.builder(

                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                    alignment:
                                    AlignmentDirectional.bottomCenter,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            image: DecorationImage(
                                              image: NetworkImage(box
                                                  .getAt(index)
                                                  .image_url !=
                                                  null
                                                  ? box
                                                      .getAt(index)
                                                      .image_url
                                                      .toString()
                                                  : 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1200px-No_image_3x4.svg.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => MyImage(
                                                      recette:box.getAt(index))));
                                        },
                                      ),
                                      Container(
                                          child: Column(children: [
                                            Expanded(child: Container(), flex: 8),
                                            Container(
                                                width: double.infinity,
                                                height: 35,
                                                color:
                                                Colors.white.withOpacity(0.7),
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8.0, left: 8.0),
                                                    child: Center(
                                                        child: Text(
                                                            Hive.box("favorites")
                                                                .get(index)
                                                                .title!,
                                                            style:
                                                            GoogleFonts.roboto(
                                                              color: CupertinoColors
                                                                  .black,
                                                              fontSize: 10,
                                                            ))))),
                                          ]))
                                    ]),
                              ),
                              Container(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    _deleteFavoris(index);
                                  },
                                  child: const Text('Effacer'),
                                ),
                              )
                            ],
                          ));
                    });
              })),
      ValueListenableBuilder(
          valueListenable: Hive.box('favorites').listenable(),
          builder: (context, Box box, _) {
            if (box.values.length == 0)
              return Container(child: Lottie.asset("assets/wok-pan-food-fry-on-fire.json"));
            return
              Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    _deleteAllFavoris();
                  },
                  child: const Text('Effacer tous les favoris'),
                ),
              );})
    ]);
  }
}