import 'package:hive/hive.dart';

part 'favourite.g.dart';

@HiveType(typeId: 3)
class Favourite extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  bool isFavourite;
}
