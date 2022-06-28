import 'package:hive/hive.dart';

part 'wishlist.g.dart';

@HiveType(typeId: 0)
class Wishlist extends HiveObject {
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
}
