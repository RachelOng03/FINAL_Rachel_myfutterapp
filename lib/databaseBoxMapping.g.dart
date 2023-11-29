// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'databaseBoxMapping.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class databaseBoxMappingAdapter extends TypeAdapter<databaseBoxMapping> {
  @override
  final int typeId = 2;

  @override
  databaseBoxMapping read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return databaseBoxMapping(
      mappingZutat_id: fields[0] as int,
      mappingRezept_id: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, databaseBoxMapping obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.mappingZutat_id)
      ..writeByte(1)
      ..write(obj.mappingRezept_id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is databaseBoxMappingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
