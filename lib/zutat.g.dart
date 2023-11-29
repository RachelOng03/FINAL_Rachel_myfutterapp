// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zutat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZutatAdapter extends TypeAdapter<Zutat> {
  @override
  final int typeId = 3;

  @override
  Zutat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Zutat(
      zutat_id: fields[0] as int,
      zutat: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Zutat obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.zutat_id)
      ..writeByte(1)
      ..write(obj.zutat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZutatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
