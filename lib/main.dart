import 'package:flutter/material.dart';
import 'package:myapp/home.dart';
import 'package:myapp/playlistProvider.dart';
import 'package:myapp/themeProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>ThemeProvider()),
    ChangeNotifierProvider(create: (context)=>PlayListProvider())
  ],child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,

    );
  }
}