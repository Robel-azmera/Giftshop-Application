// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriceInfoAdapter extends TypeAdapter<PriceInfo> {
  @override
  final int typeId = 2;

  @override
  PriceInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriceInfo()
      ..id = fields[0] as int
      ..amount = fields[1] as int
      ..price = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, PriceInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
