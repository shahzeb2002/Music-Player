import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/components/fonts.dart';
import 'package:musicplayer/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Settings',style: AppTextStyles.appBar(context),),
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15)

        ),
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.all(18),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Dark Mode',style: TextStyle(fontWeight: FontWeight.bold),),
          CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              onChanged: (value)=>Provider.of<ThemeProvider>(context,listen: false).toggleTheme())
          
        ],
      ),
      ),
    );
  }
}
