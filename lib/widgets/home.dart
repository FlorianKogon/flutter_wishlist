import 'package:flutter/material.dart';
import 'package:flutter_wishlist/models/dataBaseClient.dart';
import 'package:flutter_wishlist/models/item.dart';
import 'empty_data.dart';
import 'item_details.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => addList(null),
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
            Item item = items[i];
            return ListTile(
              leading:
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => addList(item)
                ),
              title: InkWell(
               child: Text(item.nom),
               onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext buildContext) {
                     return ItemDetail(item);
                 }));
               },
              ),
              trailing:
                IconButton(icon: Icon(Icons.delete),
                onPressed: () {
                  DataBaseClient().deleteItem(item.id, 'item').then((int) {
                    get();
                  });
                }),
            );
          },
        ),
      ),
    );
  }

  Future<Null> addList(Item item) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('Ajouter une liste de voeux'),
          content: TextField(
            decoration: InputDecoration(
              labelText: 'Nommez votre liste',
              hintText: (item == null) ? 'ex : mes prochains achats' : item.nom,
            ),
            onChanged: (String string) {
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
              onPressed: () {
                if (wishlist != null) {
                  if (item == null) {
                    item = Item();
                    Map<String, dynamic> map = {"nom" : wishlist};
                    item.fromMap(map);
                  } else {
                    item.nom = wishlist;
                  }
                  DataBaseClient().upsertItem(item).then((i) => get());
                  wishlist = null;
                }
                Navigator.pop(buildContext);
              },
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

  void get() {
    DataBaseClient().getAllItems().then((items) {
      setState(() {
        this.items = items;
        print(items);
      });
    });
  }
}
