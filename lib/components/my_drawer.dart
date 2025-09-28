import 'package:flutter/material.dart';
import 'package:musicplayer/components/drawer_list_tiles.dart';
import 'package:musicplayer/pages/home_page.dart';
import 'package:musicplayer/pages/settings_page.dart';
import 'package:musicplayer/splash_screen.dart';
import 'package:musicplayer/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //user account
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary
            ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/tupac.jpg'),
              ),
              accountName: Text("Shah Zeb",),
              accountEmail: Text('shahzebakbar1@gmail.com',)),

          //home

          DrawerListTiles(
              leadingicon: Icon(Icons.home),
              titletxt: 'Home',
              nextscreen: HomePage()),

          //library
          DrawerListTiles(
              leadingicon: Icon(Icons.library_music),
              titletxt: 'Library',
              nextscreen: HomePage()),



          //fav
          DrawerListTiles(
              leadingicon: Icon(Icons.favorite),
              titletxt: 'Favorites',
              nextscreen: HomePage()),

          //recent
          DrawerListTiles(
              leadingicon: Icon(Icons.history_outlined),
              titletxt: 'Recents',
              nextscreen: HomePage()),


          // Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 25.0,top: 20),
            child: SwitchListTile(

              title: const Text("Dark Mode"),
              secondary: Icon(
                Provider.of<ThemeProvider>(context).isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.primary,
              ),
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (value) => Provider.of<ThemeProvider>(context,listen: false).toggleTheme(),),
          ),

          //settings
          DrawerListTiles(
              leadingicon: Icon(Icons.settings),
              titletxt: 'Settings',
              nextscreen: SettingsPage()),

          //about
          DrawerListTiles(
              leadingicon: Icon(Icons.info),
              titletxt: 'About',
              nextscreen: HomePage()),

          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: DrawerListTiles(
                leadingicon: Icon(Icons.logout),
                titletxt: 'Logout',
                nextscreen: SplashScreen()),
          ),





        ],
      ),
    );
  }
}
