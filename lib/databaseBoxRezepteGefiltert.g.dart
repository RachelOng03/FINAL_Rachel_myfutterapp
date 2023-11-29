// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'databaseBoxRezepteGefiltert.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class databaseBoxRezepteGefiltertAdapter
    extends TypeAdapter<databaseBoxRezepteGefiltert> {
  @override
  final int typeId = 4;

  @override
  databaseBoxRezepteGefiltert read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return databaseBoxRezepteGefiltert(
      gefilterteRezepte_id: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, databaseBoxRezepteGefiltert obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.gefilterteRezepte_id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is databaseBoxRezepteGefiltertAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
