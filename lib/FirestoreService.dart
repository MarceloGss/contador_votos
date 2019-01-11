import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contador_votos/Model.dart';

final CollectionReference modelCollection = Firestore.instance.collection('cursos');

class FirestoreService{
  static final FirestoreService _firestoreService = new FirestoreService.internal();

  factory FirestoreService() => _firestoreService;

  FirestoreService.internal();

  Future<Model> createModel(String name, num votes) async{
    final TransactionHandler createTrans = (Transaction ts) async{
      final DocumentSnapshot ds = await ts.get(modelCollection.document());

      final Model model = new Model(ds.documentID, name, votes);
      final Map<String, dynamic> data = model.toMap();

      await ts.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTrans).then((mapData){
      return Model.fromMap(mapData);
    }).catchError((error){
      print('fail: $error');
      return null;
    });
  }
}