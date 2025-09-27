import 'package:flutter/material.dart';
import 'package:musicplayer/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(

            child:Image(image: AssetImage('assets/images/spotify_logo.png')),

          ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0,top: 20),
            child: ListTile(
              title: Text('HOME'),
              leading: Icon(Icons.home,color: Theme.of(context).colorScheme.primary,),
              onTap: () {
                Navigator.pop(context);

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0,top: 0),
            child: ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings,color: Theme.of(context).colorScheme.primary,),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));

              },
            ),
          )
        ],
      ),
    );
  }
}
