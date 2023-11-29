// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'databaseBoxFilter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class databaseBoxFilterAdapter extends TypeAdapter<databaseBoxFilter> {
  @override
  final int typeId = 1;

  @override
  databaseBoxFilter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return databaseBoxFilter(
      boxFilter_id: fields[0] as int,
      boxFilterZutat: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, databaseBoxFilter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.boxFilter_id)
      ..writeByte(1)
      ..write(obj.boxFilterZutat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is databaseBoxFilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
