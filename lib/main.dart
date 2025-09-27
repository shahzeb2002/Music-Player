import 'package:flutter/material.dart';
import 'package:musicplayer/models/playlist_provider.dart';
import 'package:musicplayer/pages/home_page.dart';
import 'package:musicplayer/splash_screen.dart';

import 'package:musicplayer/themes/theme_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>ThemeProvider()),
      ChangeNotifierProvider(create: (context)=>PlayListProvider()),
    ],child: const MyApp(),

    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:  SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}


