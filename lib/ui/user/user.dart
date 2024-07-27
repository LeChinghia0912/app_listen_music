import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Icon(Icons.person),
          middle: Text('Tài khoản'),
        ),
        child: Center(child: Text('Màn hình Tài khoản')));
  }
}
