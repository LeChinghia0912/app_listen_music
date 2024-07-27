import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoveryTab extends StatelessWidget {
  const DiscoveryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Icon(Icons.album),
          middle: Text('Album'),
        ),
        child: Center(child: Text('Màn hình Album')));
  }
}
