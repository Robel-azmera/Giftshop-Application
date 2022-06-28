class Product {
  int id;
  String name;
  String description;
  String short_description;
  String sku;
  String price;
  String regularPrice;
  String salesPrice;
  String stockStatus;
  String status;
  String catalog_visibility;
  List<Images> images;
  List<Categories> categories;

  Product({
    this.id,
    this.name,
    this.description,
    this.short_description,
    this.sku,
    this.price,
    this.regularPrice,
    this.salesPrice,
    this.stockStatus,
    this.status,
    this.catalog_visibility,
  });

  Product.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    short_description = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regularPrice'];
    salesPrice = json['salesPrice'];
    stockStatus = json['stockStatus'];
    status = json['status'];
    catalog_visibility = json['catalog_visibility'];

    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((eachCategory) =>
          categories.add(new Categories.fromJSON(eachCategory)));
    }
    if (json['images'] != null) {
      images = [];
      json['images']
          .forEach((eachImage) => images.add(new Images.fromJSON(eachImage)));
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'short_description': short_description,
        'sku': sku,
        'price': price,
        'regularPrice': regularPrice,
        'salesPrice': salesPrice,
        'stockStatus': stockStatus,
        'status': status,
        'catalog_visibility': catalog_visibility,
        'images': images[0].src,
      };
}

class Categories {
  int id;
  String name;

  Categories({this.id, this.name});

  Categories.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Images {
  String src;

  Images({this.src});

  Images.fromJSON(Map<String, dynamic> json) {
    src = json['src'];
  }
}
