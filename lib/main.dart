import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        title: const Text('Miam\'Miam'),
        centerTitle: true,
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter une recette'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
    'https://www.kitchendiet.fr/media/upload/crevettes(1).jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
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
                          borderRadius: BorderRadius.all(Radius.circular(15)),
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
                    Column(children: [
                      Container(
                        child: Icon(Icons.favorite_border),
                      ),
                      Container(
                          width: double.infinity,
                          height: 30,
                          color: Colors.blueGrey.withOpacity(0.9),
                          alignment: Alignment.bottomCenter,
                          child: Text('Toto',
                              style: GoogleFonts.courgette(
                                color: CupertinoColors.black,
                                fontSize: 25,
                              )))
                    ])
                  ]));
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, 1.5);
          //return StaggeredTile.count(index.isEven ? 1 : 2, index.isEven ? 1.2 : 1.8);
        });
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
              labelText: "Search",
              hintText: "Search",
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
          ? Expanded(child: Lottie.asset("36895-healthy-or-junk-food.json"))
          : Expanded(child: ListView.separated(
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
            ),)
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
