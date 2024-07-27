import 'dart:async';

import 'package:app_listen_music/data/model/song.dart';
import 'package:app_listen_music/data/repository/repository.dart';

// ViewModel cho ứng dụng MusicApp
class MusicAppViewModel {
  // StreamController để quản lý và phát danh sách các bài hát
  StreamController<List<Song>> songStream = StreamController();

  // Hàm loadSongs để tải danh sách bài hát từ repository
  void loadSongs() {
    final repository = DefaultRepository();
    repository.loadData().then((value) => songStream.add(value!));
  }
}
