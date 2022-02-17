import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import 'image.dart';

class Accueil extends StatelessWidget {
  List<String> imageList = [
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.bofrost.fr/medias/paella-royale-00272-1.jpg-W340xH283R1.2?context=bWFzdGVyfHByb2R1Y3QtaW1hZ2VzfDE1Nzk2NHxpbWFnZS9qcGVnfHByb2R1Y3QtaW1hZ2VzL2g4Ny9oMTAvODgxNDgwNzg3NTYxNC5qcGd8ZGYyZDg1MzliYjFlNDc5NzQwZjIxZWUxYjEwOWVlMDEzMzYyODFhNWUzYzI3NWVlNGRkMjQ5OGE1NjExZTk1Mg',
    'https://www.bienmanger.com/tinyMceData/images/categories/37/rwd/w870h395_slide-plats-viande.jpg',
    'https://lh3.googleusercontent.com/proxy/liWdnd9EnX_jl7FvWo1sFBz5_VevIJJ2U7mpeYF8GkFHNNKAGaIv3IKTqMkwFyQLJKiyZwwcwY31ua4VdSoOe_PEcPLwnktqFEWNUxgjrhdPKX1xlMPXYk8qBK_CdA6FnPHcTUrBZirWvEaS',
    'https://maison-tino.fr/wp-content/uploads/2017/04/small-cannelloni-boeuf.jpg',
    'https://lh3.googleusercontent.com/proxy/fIlqiLTho8ZVrnDnQzaMm5tX7LMW0vSqLNbXGWHbuBvFQJbsLwBdd9vjZ6izRQVD8jXzod_1gK-j4ZvJIs8YZDDx5L_MXurV_oBm3guLtwVbPV6gV-KEx87ZgCzzc36tDUT-6_EhHVLk7s2mWwEao8gqk2CW4HitZia8qHE4',
    'https://lescuisinesdarmor.com/wp-content/uploads/Compo-Poulet-1024x568.jpg',
    'https://cdn.radiofrance.fr/s3/cruiser-production/2021/02/e61a0ee6-8088-4886-b4b2-bf9733c05496/870x489_agis-amb-lasagnes-bolognaise-coupe-1kg-300dpi.jpg',
    'https://cdn3.foie-gras-godard.fr/I-Source-2172-.net.jpg',
    'https://static.750g.com/images/1200-630/5b86ec5f2891fa73aab5440dc83a5ad2/far-breton.jpeg',
    'https://fac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Ffac.2F2019.2F02.2F20.2F5aaad6d2-db3b-4616-b000-619b7b10db35.2Ejpeg/850x478/quality/90/crop-from/center/tout-savoir-sur-les-plats-cuisines-labellises-bio.jpeg',
    'https://www.gekkogourmet.net/pub/media/catalog/product/cache/873d7c3dc6690ae38f352a4bb0dc01c7/t/a/tajine_poulet_citron_confit.jpg',
    'https://maison-tino.fr/wp-content/uploads/2017/04/small-parmentier-de-boeuf.jpg',
    'https://www.lespepitesdenoisette.fr/wp-content/uploads/2020/11/Room-saveurs-denny-imbrosi-2-768x512.jpg',
    'https://www.cuisine-florian.com/wp-content/uploads/sites/6363/2018/07/dish.jpg',
    'https://www.fitnesspark.fr/wp-content/uploads/2018/01/mfc-alimentation-saine-equilibree.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                image: NetworkImage(imageList[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MyImage(image: imageList[index])));
                          },
                        ),
                        Container(
                            child: Column(children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Padding(padding: EdgeInsets.all(8.0),child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  )),),
                              ),
                              Expanded(child: Container(), flex: 8),
                              Container(
                                  width: double.infinity,
                                  height: 30,
                                  color: Colors.white.withOpacity(0.7),
                                  //alignment: Alignment.bottomCenter,
                                  /*decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),*/
                                  child: Padding(
                                      padding:
                                      EdgeInsets.only(right: 8.0, left: 8.0),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text('Crevettes coréennes',
                                              style: GoogleFonts.indieFlower(
                                                color: CupertinoColors.black,
                                                //fontSize: 25,
                                              ))))),
                            ]))
                      ]));
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, 1);
              //return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
            }));
  }
}