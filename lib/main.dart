import 'package:flutter/material.dart';
import 'package:myapp/views/favourite.dart';
import 'package:myapp/views/home.dart';
import 'package:myapp/views/settings.dart';
import 'package:myapp/views/theme_provider.dart';
import 'package:provider/provider.dart';

import 'models/recipe.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Recipe> favoriteRecipes = [];

    return MaterialApp(
      title: 'Food Recipe',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
      routes: {
        '/main_page':(context) => const HomePage(),
        '/settings':(context) => const Settings(),
        '/favourite':(context) => Favourite(favoriteRecipes: favoriteRecipes,),
      },
    );
  }
}
