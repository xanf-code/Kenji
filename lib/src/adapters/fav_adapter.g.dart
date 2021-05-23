part of 'fav_adapter.dart';

class FavouritesAdapter extends TypeAdapter<Favourites> {
  @override
  final int typeId = 1;

  @override
  Favourites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourites(
      insiderName: fields[4] as String,
      ticker: fields[0] as String,
      insiderTitle: fields[5] as String,
      date: fields[3] as String,
      companyName: fields[1] as String,
      percentage: fields[9] as String,
      purchaseType: fields[6] as String,
      quantity: fields[8] as String,
      shareValue: fields[7] as String,
      totalValue: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Favourites obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.ticker)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.insiderName)
      ..writeByte(5)
      ..write(obj.insiderTitle)
      ..writeByte(6)
      ..write(obj.purchaseType)
      ..writeByte(7)
      ..write(obj.shareValue)
      ..writeByte(8)
      ..write(obj.quantity)
      ..writeByte(9)
      ..write(obj.percentage)
      ..writeByte(10)
      ..write(obj.totalValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
