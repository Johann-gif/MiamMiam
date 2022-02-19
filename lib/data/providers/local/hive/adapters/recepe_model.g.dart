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
      recepe_id: fields[0] as int?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      image_url: fields[3] as String?,
      rating: fields[4] as int?,
      ingredients: (fields[5] as List?)?.cast<dynamic>(),
      preparation: (fields[6] as List?)?.cast<dynamic>(),
      tags: (fields[7] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecepeModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.recepe_id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image_url)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.ingredients)
      ..writeByte(6)
      ..write(obj.preparation)
      ..writeByte(7)
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
