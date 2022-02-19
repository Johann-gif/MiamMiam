// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../models/recepe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecepeModelAdapter extends TypeAdapter<RecepeModel> {
  @override
  final int typeId = 0;

  @override
  RecepeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecepeModel(
      title: fields[0] as String?,
      description: fields[1] as String?,
      image_url: fields[2] as String?,
      rating: fields[3] as int?,
      ingredients: (fields[4] as List?)?.cast<dynamic>(),
      preparation: (fields[5] as List?)?.cast<dynamic>(),
      tags: (fields[6] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecepeModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.image_url)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.ingredients)
      ..writeByte(5)
      ..write(obj.preparation)
      ..writeByte(6)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecepeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
