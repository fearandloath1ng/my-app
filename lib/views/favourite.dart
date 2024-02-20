import 'package:flutter/material.dart';
import '../models/recipe.dart';

class Favourite extends StatelessWidget {
  final List<Recipe> favoriteRecipes;

  const Favourite({required this.favoriteRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .background,
          title: const Text('Favourites')
      ),
      body: favoriteRecipes.isEmpty
          ? Center(child: Text('No favourite recipes yet'))
          :ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteRecipes[index].name),
            subtitle: Text(favoriteRecipes[index].totalTime),
          );
        },
      ),
    );
  }
}