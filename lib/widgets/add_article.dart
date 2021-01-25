import 'dart:io';
import 'package:flutter_wishlist/models/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wishlist/models/dataBaseClient.dart';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  int id;

  Add(int id) {
    this.id = id;
  }

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {

  String imagePath;
  String nom;
  String prix;
  String magasin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter"),
          actions: [
            FlatButton(onPressed: add,
              child: Text('Valider',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('Article à ajouter',
                textScaleFactor: 1.4,
                style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic
                ),
              ),
              Card(
                elevation: 10.0,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    (imagePath == null) ?
                    Image.asset('images/question.png')
                        :
                    Image.file(File(imagePath)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: Icon(Icons.camera_enhance),
                            onPressed: () => getImage(ImageSource.camera)
                        ),
                        IconButton(
                            icon: Icon(Icons.photo_library),
                            onPressed: () => getImage(ImageSource.gallery)
                        ),
                      ],
                    ),
                    textField(TypeTextField.nom, "Nom de l'article"),
                    textField(TypeTextField.prix, "Prix de l'article"),
                    textField(TypeTextField.magasin, "Nom du magasin"),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  TextField textField(TypeTextField type, String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label
      ),
      onChanged: (String string) {
        switch(type) {
          case TypeTextField.nom:
            nom = string;
            break;
          case TypeTextField.prix:
            prix = string;
            break;
          case TypeTextField.magasin:
            magasin = string;
            break;
        }
      },
    );
  }

  void add() {

    Map<String, dynamic> map = { 'nom': nom, 'item': widget.id };
    if (nom != null) {
    }
    if (magasin != null) {
      map['magasin'] = magasin;
    }
    if (prix != null) {
      map['prix'] = prix;
    }
    if (imagePath != null ) {
      map['imagePath'] = imagePath;
    }
    Article article = Article();
    article.fromMap(map);
    DataBaseClient().upsertArticle(article).then((value) => {
      imagePath = null,
      prix = null,
      nom = null,
      magasin = null,
      Navigator.pop(context)
    });
  }

  Future getImage(ImageSource imageSource) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        imagePath = File(pickedFile.path).toString();
      } else {
        print('No image selected.');
      }
    });
  }

}

enum TypeTextField {nom, prix, magasin}
