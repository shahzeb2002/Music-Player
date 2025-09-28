import 'package:flutter/material.dart';
class DrawerListTiles extends StatelessWidget {
  String titletxt;
  Widget leadingicon;
  Widget nextscreen;

  DrawerListTiles({super.key,required this.leadingicon,required this.titletxt,required this.nextscreen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0,top: 20),
      child: ListTile(
        leading:leadingicon,
        title: Text(titletxt),
        onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) =>nextscreen ,)) ,

      ),
    );
  }
}
