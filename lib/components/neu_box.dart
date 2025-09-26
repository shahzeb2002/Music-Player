import 'package:flutter/material.dart';
import 'package:musicplayer/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;

  const NeuBox({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    //is dark mode
    bool isDarkMode=Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          //dark shafow on bottom right
          BoxShadow(
            color: isDarkMode? Colors.black:Colors.grey.shade500,
            blurRadius: 15,
            offset: Offset(4, 4),
          ),

          //lighter shafow on top left
          BoxShadow(
            color: isDarkMode?Colors.grey.shade800:Colors.white,
            blurRadius: 15,
            offset: Offset(-4, -4),
          ),
        ],
      ),
      child: child,
    );
  }
}
