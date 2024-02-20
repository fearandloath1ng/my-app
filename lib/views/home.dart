import 'package:flutter/material.dart';
import 'package:myapp/views/search.dart';
import 'package:myapp/views/widgets/recipe_card.dart';
import '../models/recipe.api.dart';
import '../models/recipe.dart';
import 'details.dart';
import 'favourite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Recipe> _recipes;
  late List<Recipe> _favoriteRecipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: Search(recipes: _recipes));
          }, icon: const Icon (Icons.search)),
          IconButton(onPressed: () => Navigator.pushNamed(context, '/settings'), icon: const Icon (Icons.settings)),
          IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Favourite(favoriteRecipes: _favoriteRecipes),)),icon: const Icon (Icons.favorite_border))],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Icon(Icons.restaurant_menu),
          SizedBox(width: 10),
          Text('Food Recipes')],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index){
                return RecipeCard(
                    title: _recipes[index].name,
                    cookTime: _recipes[index].totalTime,
                    rating: _recipes[index].rating.toString(),
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            recipe: _recipes[index],),
                        )
                    ),
                    thumbnailUrl: _recipes[index].images,
                    isFavorite: _recipes[index].isFavorite,
                    toggleFavorite: () => {
                      toggleFavorite(_recipes[index]),

                    },
                );
              },
      ),
    );
  }
  void toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
      if (recipe.isFavorite) {
        _favoriteRecipes.add(recipe);
      } else {
        _favoriteRecipes.remove(recipe);
      }
    });
  }
}

