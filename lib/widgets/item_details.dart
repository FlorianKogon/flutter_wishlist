import 'package:flutter/material.dart';
import 'package:flutter_wishlist/models/item.dart';

class ItemDetail extends StatefulWidget {
  Item item;

  ItemDetail(Item item) {
    this.item = item;
  }
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.nom),
      ),
      body: Container(
      ),
    );
  }
}
