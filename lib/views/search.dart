import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'details.dart';

class Search extends SearchDelegate<String> {
  final List<Recipe> recipes;

  Search({required this.recipes});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Recipe> searchResults = recipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].name),
          onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Details(recipe: searchResults[index]),
            ),
          );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Recipe> searchResults = recipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].name),
          onTap: () {
            query = searchResults[index].name;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(recipe: searchResults[index]),
              ),
            );
          },
        );
      },
    );
  }
}