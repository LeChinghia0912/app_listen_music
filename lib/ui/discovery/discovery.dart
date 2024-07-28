import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoveryTab extends StatelessWidget {
  const DiscoveryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Khám phá'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // Add your onPressed logic here
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
        children: [
          _buildSectionTitle('Playlist nổi bật'),
          _buildPlaylistCard(
            'Top Hits',
            'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/e/2/8/9/e289c5542de3a85d7253e10ca7f1cf6d.jpg',
          ),
          _buildPlaylistCard(
            'Nhạc mới',
            'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/b/2/a/d/b2add073d4cd36ffe73d681663f73531.jpg',
          ),
          _buildSectionTitle('Album nổi bật'),
          _buildAlbumCard(
            'Album 1',
            'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/0/a/3/4/0a3402da6fdd36afb3183e271306b226.jpg',
          ),
          _buildAlbumCard(
            'Album 2',
            'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/cover/d/2/8/9/d2896c3b4cd992a27eee9f004501856e.jpg',
          ),
          _buildSectionTitle('Nghệ sĩ nổi bật'),
          _buildArtistCard(
            'Sơn Tùng M-TP',
            'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2019/9/6/753212/Son-Tung-Mtp.jpg',
          ),
          _buildArtistCard(
            'Suni Hạ Linh',
            'https://trixie.com.vn/media/images/article/72938561/104908096_623934838236207_6439286995601265384_o-1241.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
          letterSpacing: 1.5,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  Widget _buildPlaylistCard(String title, String imageUrl) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
              imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('Nghe ngay những bài hát hot nhất'),
        trailing: const Icon(Icons.play_arrow, color: Colors.blueAccent),
        onTap: () {},
      ),
    );
  }

  Widget _buildAlbumCard(String title, String imageUrl) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
              imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('Những album nổi bật'),
        trailing: const Icon(Icons.album, color: Colors.blueAccent),
        onTap: () {},
      ),
    );
  }

  Widget _buildArtistCard(String title, String imageUrl) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 25,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('Những nghệ sĩ nổi bật'),
        trailing: const Icon(Icons.person, color: Colors.blueAccent),
        onTap: () {},
      ),
    );
  }
}
