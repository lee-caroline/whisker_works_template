// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mouse_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MouseDataAdapter extends TypeAdapter<MouseData> {
  @override
  final int typeId = 0;

  @override
  MouseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MouseData(
      id: fields[0] as String,
      strain: fields[1] as String,
      treatment: fields[2] as String,
      sex: fields[3] as String,
      procedure: fields[4] as String,
      researcher: fields[5] as String,
      dob: fields[6] as String,
      status: fields[7] as String,
      cage: fields[8] as String,
      timestamp: fields[9] as String,
      litterDob: fields[10] as String?,
      litterWeanDate: fields[11] as String?,
      litterSexCount: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MouseData obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.strain)
      ..writeByte(2)
      ..write(obj.treatment)
      ..writeByte(3)
      ..write(obj.sex)
      ..writeByte(4)
      ..write(obj.procedure)
      ..writeByte(5)
      ..write(obj.researcher)
      ..writeByte(6)
      ..write(obj.dob)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.cage)
      ..writeByte(9)
      ..write(obj.timestamp)
      ..writeByte(10)
      ..write(obj.litterDob)
      ..writeByte(11)
      ..write(obj.litterWeanDate)
      ..writeByte(12)
      ..write(obj.litterSexCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MouseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
