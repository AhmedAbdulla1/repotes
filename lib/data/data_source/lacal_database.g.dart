// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lacal_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddColumnModelAdapter extends TypeAdapter<AddColumnModel> {
  @override
  final int typeId = 1;

  @override
  AddColumnModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddColumnModel(
      columnName: fields[0] as String,
      latitude: fields[2] as String,
      longitude: fields[1] as String,
      images: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AddColumnModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.columnName)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddColumnModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
