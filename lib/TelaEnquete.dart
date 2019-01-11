import 'package:flutter/material.dart';
import 'package:contador_votos/TelaAdm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contador_votos/Model.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() {
    return _MainHomePageState();
  }
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Enquete'),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ControlAdm(Model(null,'',0))),
              );
            },
          ),
        ],
      ),
      body: _buildBody(context),

    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('cursos').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),

        child: ListTile(

          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          //permite a contagem de votos corretamente, evitando um erro quando dois ou mais usuarios realizarem a votação ao mesmo tempo
          onTap: () => Firestore.instance.runTransaction((transaction) async {
            final freshSnapshot = await transaction.get(record.reference);
            final fresh = Record.fromSnapshot(freshSnapshot);

            await transaction
                .update(record.reference, {'votes': fresh.votes + 1});
          }),
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}