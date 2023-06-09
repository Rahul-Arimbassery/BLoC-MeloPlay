import 'package:hive/hive.dart';

part 'playlistnamearray.g.dart';

@HiveType(typeId: 2)
class Playlistarray extends HiveObject {
  @HiveField(1)
  late String playlistName;

  @HiveField(2)
  late List<int> playlistIndexarray = [];

  Playlistarray({
    required this.playlistName,
    List<int>? playlistIndexarray,
  }) {
    if (playlistIndexarray != null) {
      this.playlistIndexarray = playlistIndexarray;
    }
  }
}
