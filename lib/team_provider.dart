
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TeamProvider extends ChangeNotifier {

  // late String name;
  // late int age;
  // late int jersey_number;
  // late String nationality;
  // late String country;
  // late String position;

  CollectionReference team = FirebaseFirestore.instance.collection("Team");
  String? docID;

  //add Player to team
  addFirebase(String name,int jersey_number,String country,String position) async {
    await team.add({
      "name": name,
      "country": country,
      "jersey_number" : jersey_number,
      "position" : position
    });
  }

  updateFirebase(String name,int jersey_number,String country,String position)async{
  await team.where('name',isEqualTo: name).get().then((snap){
    snap.docs.forEach((doc) {
     docID = doc.id;
    });
  });
  print(docID);

  await team.doc(docID).update({
    "country": country,
    "jersey_number" : jersey_number,
    "position" : position,
  });
  }

  deleteData(String name)async{
    await team.where('name',isEqualTo: name).get().then((snap){
      snap.docs.forEach((doc) {
        docID = doc.id;
      });
    });
    await team.doc(docID).delete();
  }
}
