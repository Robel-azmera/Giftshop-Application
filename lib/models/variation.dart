class Variation {
  int id;
  String price;
  String description;

  Variation({this.id, this.price});

  Variation.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.price;
    data['description'] = this.description;
    return data;
  }
}
