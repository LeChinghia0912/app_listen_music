import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const SettingsTab({
    required this.onThemeChanged,
    required this.isDarkMode,
    super.key,
  });

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool switchValue1 = false;
  bool switchValue2 = false;
  bool switchValue3 = false;

  @override
  void initState() {
    super.initState();
    switchValue1 = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Icon(
          Icons.settings,
          color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
        ),
        middle: Text(
          'Cài đặt',
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSwitch('Giao diện tối', switchValue1, (bool value) {
              setState(() {
                switchValue1 = value;
              });
              widget.onThemeChanged(value);
            }),
            _buildSwitch('Tùy chọn 2', switchValue2, (bool value) {
              setState(() {
                switchValue2 = value;
              });
            }),
            _buildSwitch('Tùy chọn 3', switchValue3, (bool value) {
              setState(() {
                switchValue3 = value;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              decoration: TextDecoration.none,
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
