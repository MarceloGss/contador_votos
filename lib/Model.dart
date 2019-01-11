import 'package:firebase_database/firebase_database.dart';

class Model{
  String _id;
  String _name;
  num _votes;

  Model(this._id, this._name, this._votes);

  Model.map(dynamic obj){
    this._id = obj['id'];
    this._name = obj['name'];
    this._votes = obj['votes'];
  }

  String get id => _id;
  String get name => _name;
  num get votes => _votes;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    if(_id !=null){
      map['id'] = _id;
    }
    map['name'] = _name;
    map['votes'] = _votes;

    return map;
  }

  Model.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
    this._votes = map['votes'];
  }
}