import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:miammiam/data/models/user_model.dart';

class StorageHelper {
  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  var uid = Hive.box("connection").get("uid");

  Future<String?> getUserName(userId) async {
    UserModel res = new UserModel();
    await users.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        res = UserModel.fromMap(documentSnapshot.data());
      }
    });
    return res.nom;
  }

  Future<void> saveComment( { commentText, recepe_id}) async {
    comments
        .add({
      "comment": commentText,
      "UserUid": uid,
      "recepe_id": recepe_id,
      "date" : DateTime.now().toString(),
    })
        .then((value) => print("Comment Added"))
        .catchError((error) => print("Failed to add comment: $error"));
  }

  Future<List> getComment(recepe_id) async {
    var res = [];
    await comments.orderBy("timestamp")
        .where("recepe_id", isEqualTo: recepe_id)
        .get()
        .then((querySnapshot) => {
      for (var document in querySnapshot.docs)
        {res.add(document.data())}
    });
    return res;
  }

  Future<List> getUsers() async {
    var res = [];
    await users
        .get()
        .then((QuerySnapshot querySnapshot){
      for (var document in querySnapshot.docs){
        res.add(document.data());
      }
    });
    return res;
  }
}
