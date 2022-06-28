import 'package:hive/hive.dart';

part 'price_info.g.dart';

@HiveType(typeId: 2)
class PriceInfo extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int amount;

  @HiveField(2)
  int price;
}
