import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/themeProvider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text("S E T T I N G S"),centerTitle: true,),
      body: Container(decoration: 
      BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12)
      
      ),
        margin: const EdgeInsets.all(25.0),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dark Mode"),
            CupertinoSwitch(value: Provider.of<ThemeProvider>(context,listen:false).isDarkMode, onChanged: (value)=>Provider.of<ThemeProvider>(context,listen: false).toggleTheme())],),),
    );
  }
}
