class Article {
  int id;
  String nom;
  int item;
  var prix;
  String magasin;
  String imagePath;

  Article();

  void fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nom = map['nom'];
    this.item = map['item'];
    this.prix = map['prix'];
    this.magasin = map['magasin'];
    this.imagePath = map['imagePath'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nom' : this.nom,
      'item' : this.item,
      'magasin' : this.magasin,
      'prix' : this.prix,
      'imagePath' : this.imagePath,
    };
    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}