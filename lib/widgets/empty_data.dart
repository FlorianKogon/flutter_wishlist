import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Aucune donnée n'est présente",
      textScaleFactor: 2.5,
        style: TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }
}