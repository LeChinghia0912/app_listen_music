import 'package:app_listen_music/data/model/song.dart';
import 'package:app_listen_music/data/repository/repository.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var repository = DefaultRepository();
  var songs = await repository.loadData();
  if (songs != null) {
    for (var song in songs) {
      debugPrint(song.toString());
    }
  }

  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Music App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Music App',
                style: TextStyle(fontSize: 24),
              ),
              FutureBuilder<List<Song>?>(
                future: DefaultRepository().loadData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No songs available.');
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var song = snapshot.data![index];
                          return ListTile(
                            title: Text(song.title),
                            subtitle: Text('${song.artist} - ${song.album}'),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
