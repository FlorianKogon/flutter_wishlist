import 'package:flutter/material.dart';
import 'package:flutter_wishlist/models/dataBaseClient.dart';
import 'package:flutter_wishlist/models/item.dart';
import 'empty_data.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String wishlist;
  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: addList,
            icon: Icon(
              Icons.add
            ),
          ),
        ],
      ),
      body: (items.length == 0 || items == null) ?
      EmptyData()
      :
      Center(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, i) {
            return ListTile(
              leading: Icon(Icons.edit),
              title: Text(items[i].nom),
              trailing: Icon(Icons.delete),
            );
          },
        ),
      ),
    );
  }

  Future<Null> addList() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('Ajouter une liste de voeux'),
          content: TextField(
            decoration: InputDecoration(
              labelText: 'Nommez votre liste',
              hintText: 'ex : mes prochains achats',
            ),
            onSubmitted: (String string) {
              wishlist = string;
            },
          ),
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(buildContext),
              color: Colors.red,
              child: Text(
                'Annulez'
              ),
            ),
            FlatButton(
              onPressed: () => Navigator.pop(buildContext),
              color: Colors.teal,
              child: Text(
                'Validez'
              ),
            ),
          ],
        );
      }
    );
  }
}
