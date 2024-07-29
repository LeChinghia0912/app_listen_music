import 'package:app_listen_music/data/model/song.dart';
import 'package:app_listen_music/ui/discovery/discovery.dart';
import 'package:app_listen_music/ui/home/viewmodel.dart';
import 'package:app_listen_music/ui/now_playing/audio_player_manager.dart';
import 'package:app_listen_music/ui/now_playing/playing.dart';
import 'package:app_listen_music/ui/settings/settings.dart';
import 'package:app_listen_music/ui/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// widget Chính MusicApp.
class MusicApp extends StatefulWidget {
  const MusicApp({super.key});

  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Xây dựng MaterialApp chính.
    return MaterialApp(
      title: 'MusicApp',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MusicHomePage(
        onThemeChanged: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Trang chủ của ứng dụng với quản lý trạng thái.
class MusicHomePage extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const MusicHomePage({
    required this.onThemeChanged,
    required this.isDarkMode,
    super.key,
  });

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  // Định nghĩa các tab cho thanh điều hướng.
  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      HomeTab(
        onThemeChanged: widget.onThemeChanged,
        isDarkMode: widget.isDarkMode,
      ),
      const DiscoveryTab(),
      const AccountTab(),
      SettingsTab(
        onThemeChanged: widget.onThemeChanged,
        isDarkMode: widget.isDarkMode,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Xây dựng điều hướng theo phong cách Cupertino.
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Colors.blue,
          inactiveColor: isDarkMode ? Colors.white : Colors.black,
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          // Khởi tạo item cho thanh điều hướng
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
            BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Album'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Tài khoản'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Cài đặt'),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          // Xây dựng từng tab dựa trên chỉ số.
          return _tabs[index];
        },
      ),
    );
  }
}

// Widget tab Trang chủ.
class HomeTab extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const HomeTab({
    required this.onThemeChanged,
    required this.isDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // Xây dựng trang theo Cupertino cho tab Trang chủ.
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Icon(
          Icons.home,
          color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
        ),
        middle: Text(
          'Trang chủ',
          style: TextStyle(
            color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
          ),
        ),
        backgroundColor: isDarkMode ? CupertinoColors.black : CupertinoColors.white,
        border: Border(
          bottom: BorderSide(
            color: isDarkMode ? CupertinoColors.white.withOpacity(0.2) : CupertinoColors.black.withOpacity(0.2),
            width: 0.0,
          ),
        ),
      ),
      child: HomeTabPage(
        onThemeChanged: onThemeChanged,
        isDarkMode: isDarkMode,
      ),
    );
  }
}

// Trang tab Trang chủ với quản lý trạng thái.
class HomeTabPage extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const HomeTabPage({
    required this.onThemeChanged,
    required this.isDarkMode,
    super.key,
  });

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  // Danh sách các bài hát
  List<Song> songs = [];

  // Khởi tạo ViewModel của ứng dụng nhạc
  late MusicAppViewModel _viewModel;

  @override
  void initState() {
    _viewModel = MusicAppViewModel();
    _viewModel.loadSongs(); //hàm loadSongs() để tải danh sách bài hát
    observeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Xây dựng scaffold chính cho trang tab Trang chủ.
    return Scaffold(
      body: getBody(),
    );
  }

  @override
  void dispose() {
    _viewModel.songStream.close();
    AudioPlayerManager().dispose();
    super.dispose();
  }

  // Trả về scaffold.
  Widget getBody() {
    bool showLoading = songs.isEmpty;
    if (showLoading) {
      return getProgressBar();
    } else {
      return getListView();
    }
  }

  // Trả về thanh tiến trình nếu chưa tải được danh sách bài hát.
  Widget getProgressBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // Trả về danh sách bài hát nếu đã tải được.
  Widget getListView() {
    return ListView.separated(
      //Hàm xây dựng phần tử cho ListView
      itemBuilder: (context, position) {
        return getRow(position); // getRow để tạo từng phần tử
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        );
      },
      itemCount: songs.length,
      shrinkWrap: true, // scrollView
    );
  }

  // Trả về một hàng cho mỗi bài hát.
  Widget getRow(int index) {
    return _SongItemSection(parent: this, song: songs[index]);
  }

  // dữ liệu từ ViewModel và cập nhật trạng thái.
  void observeData() {
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Container(
              height: 300,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Danh sách phát.'),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Thêm'))
                  ],
                ),
              ),
            ),
          );
        });
  }

  void navigate(Song song) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return NowPlaying(
        songs: songs,
        playingSong: song,
      );
    }));
  }
}

// Item section Hiển thị danh sách bài hát
class _SongItemSection extends StatelessWidget {
  const _SongItemSection({
    required this.parent,
    required this.song,
  });

  final _HomeTabPageState parent;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 26,
        right: 10,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/zing3.png',
          image: song.image,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/zing3.png',
              width: 48,
              height: 48,
            );
          },
        ),
      ),
      title: Text(
        song.title,
      ),
      subtitle: Text(song.artist),
      trailing: IconButton(
        icon: const Icon(Icons.more_horiz),
        onPressed: () {
          parent.showBottomSheet();
        },
      ),
      onTap: () {
        parent.navigate(song);
      },
    );
  }
}
