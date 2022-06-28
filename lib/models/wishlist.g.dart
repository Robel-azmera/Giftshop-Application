// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistAdapter extends TypeAdapter<Wishlist> {
  @override
  final int typeId = 0;

  @override
  Wishlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wishlist()
      ..id = fields[0] as int
      ..name = fields[1] as String
      ..description = fields[2] as String
      ..shortDescription = fields[3] as String
      ..sku = fields[4] as String
      ..price = fields[5] as String
      ..regularPrice = fields[6] as String
      ..salesPrice = fields[7] as String
      ..stockStatus = fields[8] as String
      ..status = fields[9] as String
      ..catalog_visibility = fields[10] as String
      ..images = fields[11] as String;
  }

  @override
  void write(BinaryWriter writer, Wishlist obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.shortDescription)
      ..writeByte(4)
      ..write(obj.sku)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.regularPrice)
      ..writeByte(7)
      ..write(obj.salesPrice)
      ..writeByte(8)
      ..write(obj.stockStatus)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.catalog_visibility)
      ..writeByte(11)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
