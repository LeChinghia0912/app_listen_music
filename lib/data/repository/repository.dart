import 'package:app_listen_music/data/model/song.dart';
import 'package:app_listen_music/data/source/source.dart';

abstract class Repository {
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    var remoteSongs = await _remoteDataSource.loadData();
    if (remoteSongs == null) {
      var localSongs = await _localDataSource.loadData();
      if (localSongs != null) {
        songs.addAll(localSongs);
      }
    } else {
      songs.addAll(remoteSongs);
    }
    return songs;
  }
}
