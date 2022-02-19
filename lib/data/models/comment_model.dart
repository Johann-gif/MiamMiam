import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel{
  int? recepe_id;
  String? userId;
  Timestamp? timestamp;
  String? comment;

  CommentModel({this.recepe_id, this.userId, this.timestamp, this.comment});


//retour serveur
  factory CommentModel.fromMap(map){
    return CommentModel(
        recepe_id: map['recepe_id'],
        userId: map['userId'],
        timestamp: map['timestamp'],
        comment: map['comment']
    );
  }

//envoie vers serveur
  Map<String,dynamic> toMap(){
    return{
      'recepe_id': recepe_id,
      'userId': userId,
      'timestamp': timestamp,
      'comment': comment
    };
  }
}