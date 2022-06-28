class Category {
  int categoryID;
  String categoryName;
  String categoryDescription;
  Image image;

  Category(
      {this.categoryID,
      this.categoryName,
      this.categoryDescription,
      this.image});

  Category.fromJSON(Map<String, dynamic> json) {
    categoryID = json["id"];
    categoryName = json["name"];
    categoryDescription = json["description"];
    image = json["image"] != null ? new Image.fromJSON(json["image"]) : null;
  }
}

class Image {
  String url;

  Image({this.url});

  Image.fromJSON(Map<String, dynamic> json) {
    url = json['src'] == true || json['src'] == false ? null : json['src'];
  }
}
