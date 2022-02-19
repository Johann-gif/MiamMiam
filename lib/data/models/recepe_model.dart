import 'package:hive/hive.dart';

part '../providers/local/hive/adapters/recepe_model.g.dart';

@HiveType(typeId: 0)
class RecepeModel{
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? image_url;
  @HiveField(3)
  int? rating;
  @HiveField(4)
  List<dynamic>? ingredients;
  @HiveField(5)
  List<dynamic>? preparation;
  @HiveField(6)
  List<dynamic>? tags;

  RecepeModel({this.title, this.description, this.image_url, this.rating, this.ingredients, this.preparation, this.tags});


//retour serveur
  factory RecepeModel.fromMap(map){
    return RecepeModel(
      title: map['title'],
      description: map['description'],
      image_url: map['image_url'],
      rating: map['rating'],
      ingredients: map['ingredients'],
      preparation : map['preparation'],
      tags : map['tags']
    );
  }

//envoie vers serveur
  Map<String,dynamic> toMap(){
    return{
      'title': title,
      'description': description,
      'image_url': image_url,
      'rating': rating,
      'ingredients': ingredients,
      'preparation' : preparation,
      'tags' : tags
    };
  }
}