import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/widgets/item_ingredients.dart';
import 'package:meals_app/widgets/item_steps.dart';
import 'package:meals_app/widgets/meal_item_image.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  void _onToggleFavoriteMeals(WidgetRef ref, BuildContext context) {
    final wasAdded =
        ref.read(favoriteMealsProvider.notifier).toggleMealFavorites(meal);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(wasAdded ? 'Added to favorites!' : 'Removed from favorites!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
            onPressed: () {
              _onToggleFavoriteMeals(ref, context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: meal.id,
            child: MealItemImage(meal: meal),
          ),
          const SizedBox(height: 14),
          ItemIngredients(ingredients: meal.ingredients),
          const SizedBox(height: 20),
          ItemSteps(steps: meal.steps),
        ],
      ),
    );
  }
}
