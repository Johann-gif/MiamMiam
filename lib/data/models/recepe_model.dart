import 'package:analyzer/dart/element/type.dart';

class RecepeModel{
  String? title;
  String? description;
  String? image_url;
  int? rating;
  List<dynamic>? ingredients;
  List<dynamic>? preparation;
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