// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistnamearray.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistarrayAdapter extends TypeAdapter<Playlistarray> {
  @override
  final int typeId = 2;

  @override
  Playlistarray read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlistarray(
      playlistName: fields[1] as String,
      playlistIndexarray: (fields[2] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Playlistarray obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.playlistName)
      ..writeByte(2)
      ..write(obj.playlistIndexarray);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistarrayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
