import 'package:flutter/material.dart';
import 'package:contador_votos/FirestoreService.dart';
import 'package:contador_votos/Model.dart';


class TelaAdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Admin',
      home: ControlAdm(Model(null, '', 0)),

    );
  }
}

class ControlAdm extends StatefulWidget{
  final Model model;
  ControlAdm(this.model);

  @override
  _ControlAdmState createState() {
    return _ControlAdmState();
  }
}

class _ControlAdmState extends State<ControlAdm>{
  FirestoreService store = new FirestoreService();

  //TextEditingController _temaControl;
  TextEditingController _op1Control;

  @override
  void initState(){
    super.initState();
    _op1Control = new TextEditingController(text: widget.model.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Admin"),
      ),
      body: _AdmBody(context),
    );
  }
  num votes = 0;
  Widget _AdmBody(BuildContext context){
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _op1Control,
              decoration: InputDecoration(labelText: 'Campo'),
            ),
          ],
        ),
      ),
      //adiciona opções
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.assignment_turned_in) ,
        onPressed: (){
            store.createModel(_op1Control.text, votes)
            .then((_){
            Navigator.pop(context);
                });
        }
        //child: Icon(Icons.assignment_turned_in),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
