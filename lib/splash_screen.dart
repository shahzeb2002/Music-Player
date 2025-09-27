import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musicplayer/pages/home_page.dart';
import 'package:musicplayer/themes/theme_provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    },);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/images/spotify_logo.png')),
          SizedBox(height: 10,),
          Text('Spotify',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.green),)
          ,SizedBox(height: 10,),
          Text('Bringing Everyone Together',style: TextStyle(fontSize: 14,wordSpacing: 5),),

        ],
      ),
    );
  }
}
