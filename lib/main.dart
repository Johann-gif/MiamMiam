import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'image.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      return SomethingWentWrong();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }

    return MyAwesomeApp();
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miam\'Miam',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Text('Loading...')
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Miam\'Miam',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Text('SomethingWentWrong...')
    );
  }
}

class MyAwesomeApp extends StatelessWidget {
  const MyAwesomeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Miam\'Miam',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _accueil = Accueil();
  Widget _recherche = Recherche();
  Widget _favoris = Favoris();
  Widget _profil = Profil();

  void _incrementCounter() {
    setState(() {});
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getBody() {
    if (this._selectedIndex == 0) {
      return this._accueil;
    } else if (this._selectedIndex == 1) {
      return this._recherche;
    } else if (this._selectedIndex == 2) {
      return this._favoris;
    } else {
      return this._profil;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

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
      body: getBody(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter une recette'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Accueil',
            tooltip: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Rechercher',
            tooltip: 'Rechercher',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favoris',
            tooltip: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'Profil',
            tooltip: 'Profil',
            //backgroundColor: Colors.grey,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        unselectedItemColor: Colors.blue,
        showUnselectedLabels: true,
      ),
    );
  }
}

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
    return ListView(
      children: [
        Carroussel(),
        Recepes()
      ],
    );
  }
}

class Recepes extends StatefulWidget {
  @override
  _RecepeState createState() => _RecepeState();
}

class _RecepeState extends State<Recepes> {
  final Stream<QuerySnapshot> _recepesStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _recepesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

            /*return StaggeredGridView.countBuilder(
                shrinkWrap: true,
                crossAxisCount: 2,
                physics: ClampingScrollPhysics(),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                itemCount: data.length,
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
                                    image: NetworkImage(data['image_url']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MyImage(image: data['image_url'])));
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
                                      *//*decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),*//*
                                      child: Padding(
                                          padding:
                                          EdgeInsets.only(right: 8.0, left: 8.0),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(data['title'],
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
                });
          }).toList(),*/
            return ListTile(
        title: Text(data['title']),
        subtitle: Text(data['image_url']),
        );
      }).toList(),
        );
      },
    );
  }
}

class Carroussel extends StatefulWidget {
  const Carroussel({Key? key}) : super(key: key);

  @override
  _CarrousselState createState() => _CarrousselState();
}

class _CarrousselState extends State<Carroussel> {
  int _currentIndex=0;
  List cardList=[
    Item1(),
    Item2(),
    Item3(),
  ];
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
        height: 200.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(seconds: 2),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        enlargeCenterPage: true,
        pageSnapping: true,
        aspectRatio: 2.0,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      items: cardList.map((card){
        return Builder(
            builder:(BuildContext context){
              return Container(
                height: MediaQuery.of(context).size.height*0.30,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.blueAccent,
                  child: card,
                ),
              );
            }
        );
      }).toList(),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(cardList, (index, url) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }),
        ),
    ]);
  }
}

class Item1 extends StatelessWidget {
  const Item1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xffff4000),Color(0xffffcc66),]
        ),
      ),
      child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage('https://www.bofrost.fr/medias/paella-royale-00272-1.jpg-W340xH283R1.2?context=bWFzdGVyfHByb2R1Y3QtaW1hZ2VzfDE1Nzk2NHxpbWFnZS9qcGVnfHByb2R1Y3QtaW1hZ2VzL2g4Ny9oMTAvODgxNDgwNzg3NTYxNC5qcGd8ZGYyZDg1MzliYjFlNDc5NzQwZjIxZWUxYjEwOWVlMDEzMzYyODFhNWUzYzI3NWVlNGRkMjQ5OGE1NjExZTk1Mg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MyImage(image: 'https://www.bofrost.fr/medias/paella-royale-00272-1.jpg-W340xH283R1.2?context=bWFzdGVyfHByb2R1Y3QtaW1hZ2VzfDE1Nzk2NHxpbWFnZS9qcGVnfHByb2R1Y3QtaW1hZ2VzL2g4Ny9oMTAvODgxNDgwNzg3NTYxNC5qcGd8ZGYyZDg1MzliYjFlNDc5NzQwZjIxZWUxYjEwOWVlMDEzMzYyODFhNWUzYzI3NWVlNGRkMjQ5OGE1NjExZTk1Mg')
                    ));
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
          ])
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff5f2c82), Color(0xff49a09d)]
        ),
      ),
      child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage('https://www.kitchendiet.fr/media/upload/crevettes(1).jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MyImage(image: 'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg')
                ));
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
          ])
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xffff4000),Color(0xffffcc66),]
        ),
      ),
      child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage('https://www.bienmanger.com/tinyMceData/images/categories/37/rwd/w870h395_slide-plats-viande.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MyImage(image: 'https://www.bienmanger.com/tinyMceData/images/categories/37/rwd/w870h395_slide-plats-viande.jpg')
                ));
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
          ])
    );
  }
}

class Recherche extends StatefulWidget {
  const Recherche({Key? key}) : super(key: key);

  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  bool _isStartersOn = false;
  bool _isDishesOn = false;
  bool _isDesertsOn = false;

  bool _isSearchEmpty = true;

  final duplicateItems = List<String>.generate(10, (i) => "Item $i");

  void filterSearchResults(String query) {
    setState(() {
      _isSearchEmpty = query.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          //controller: editingController,
          onChanged: (value) {
            filterSearchResults(value);
          },
          decoration: InputDecoration(
              labelText: "Rechercher",
              hintText: "Quiche loraine...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Row(children: [
            ActionChip(
              elevation: 8.0,
              padding: EdgeInsets.all(2.0),
              avatar: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(
                  _isStartersOn
                      ? Icons.bakery_dining_rounded
                      : Icons.bakery_dining_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              label: Text('Entrées'),
              onPressed: () {
                setState(() {
                  _isStartersOn = !_isStartersOn;
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Entrées')));
              },
              backgroundColor: Colors.grey[200],
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
            ),
            ActionChip(
              elevation: 8.0,
              padding: EdgeInsets.all(2.0),
              avatar: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(
                  _isDishesOn
                      ? Icons.bakery_dining_rounded
                      : Icons.bakery_dining_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              label: Text('Plats'),
              onPressed: () {
                setState(() {
                  _isDishesOn = !_isDishesOn;
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Plats')));
              },
              backgroundColor: Colors.grey[200],
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
            ),
            ActionChip(
              elevation: 8.0,
              padding: EdgeInsets.all(2.0),
              avatar: CircleAvatar(
                backgroundColor: Colors.yellowAccent,
                child: Icon(
                  _isDesertsOn
                      ? Icons.bakery_dining_rounded
                      : Icons.bakery_dining_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              label: Text('Desserts'),
              onPressed: () {
                setState(() {
                  _isDesertsOn = !_isDesertsOn;
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Desserts')));
              },
              backgroundColor: Colors.grey[200],
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.redAccent,
              )),
            ),
          ])),
      _isSearchEmpty
          ? Expanded(child: Lottie.asset("assets/food.json"))
          : Expanded(
              child: ListView.separated(
                itemCount: duplicateItems.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(duplicateItems[index]),
                    leading: Icon(Icons.favorite),
                    onTap: () {
                      // action
                    },
                  );
                },
              ),
            )
    ]));
  }
}

class Favoris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Favoris"));
  }
}

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profil"));
  }
}
