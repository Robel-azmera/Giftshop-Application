import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 1)
class Cart extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String shortDescription;

  @HiveField(4)
  String sku;

  @HiveField(5)
  String price;

  @HiveField(6)
  String regularPrice;

  @HiveField(7)
  String salesPrice;

  @HiveField(8)
  String stockStatus;

  @HiveField(9)
  String status;

  @HiveField(10)
  String catalog_visibility;

  @HiveField(11)
  String images;

  Cart({
    this.status,
    this.description,
    this.id,
    this.images,
    this.name,
    this.price,
    this.regularPrice,
    this.salesPrice,
    this.shortDescription,
    this.sku,
    this.stockStatus,
    this.catalog_visibility,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catalog_visibility'] = this.catalog_visibility;
    data['description'] = this.description;
    data['name'] = this.name;
    data['id'] = this.id;
    data['shortDescription'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regularPrice'] = this.regularPrice;
    data['salesPrice'] = this.salesPrice;
    data['stockStatus'] = this.stockStatus;
    data['status'] = this.status;
    data['images'] = this.images;

    return data;
  }
}
