import 'package:flutter/material.dart';
import 'package:flutter_wishlist/models/item.dart';
import 'package:flutter_wishlist/models/article.dart';
import 'package:flutter_wishlist/widgets/add_article.dart';
import 'empty_data.dart';
import 'package:flutter_wishlist/models/dataBaseClient.dart';
import 'dart:io';

class ItemDetail extends StatefulWidget {
  Item item;

  ItemDetail(Item item) {
    this.item = item;
  }

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {

  List<Article> articles;

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
        title: Text(widget.item.nom),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext buildContext) {
                print(widget.item.id);
                return Add(widget.item.id);
              })).then((value) => {
                DataBaseClient().getAllArticles(widget.item.id).then((liste) {
                  setState(() {
                    articles = liste;
                  });
                })
              });
            },
            child: Text(
              'Ajouter',
              style: TextStyle(
                color: Colors.white,
              ),
            ))
        ],
      ),
      body: (articles == null || articles.length == 0) ? EmptyData() :
      GridView.builder(
        itemCount: articles.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, i) {
          Article article = articles[i];
          return Card(
            child: Column(
              children: [
                Text(article.nom),
                (article.imagePath == null) ?
                    Image.asset('images/question.png', width: MediaQuery.of(context).size.width / 3,)
                    :
                    Image.file(File(article.imagePath)),
                (article.prix == null) ? Text('Aucun prix renseigné') : Text('Prix : ${article.prix}'),
                (article.magasin == null) ? Text('Aucun magasin renseigné') : Text('Magasin : ${article.magasin}'),
              ],
            ),
          );
        },
      ),
    );
  }

  void get() {
    DataBaseClient().getAllArticles(widget.item.id).then((articles) {
      setState(() {
        this.articles = articles;
      });
    });
  }
}
