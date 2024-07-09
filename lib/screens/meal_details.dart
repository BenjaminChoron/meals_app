import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/widgets/item_ingredients.dart';
import 'package:meals_app/widgets/item_steps.dart';
import 'package:meals_app/widgets/meal_item_image.dart';

class MealDetailsScreen extends ConsumerStatefulWidget {
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
  ConsumerState<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends ConsumerState<MealDetailsScreen> {
  int _selectedTabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _setTab(String identifier) async {
    if (identifier == 'ingredients') {
      _selectTab(0);
    } else if (identifier == 'steps') {
      _selectTab(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(widget.meal);
    Widget activeTab = ItemIngredients(ingredients: widget.meal.ingredients);

    if (_selectedTabIndex == 1) {
      activeTab = ItemSteps(steps: widget.meal.steps);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meal.title,
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
              widget._onToggleFavoriteMeals(ref, context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: widget.meal.id,
            child: MealItemImage(meal: widget.meal),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: _selectedTabIndex == 0
                    ? BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      )
                    : null,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _setTab('ingredients');
                    });
                  },
                  child: Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: _selectedTabIndex == 0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Container(
                decoration: _selectedTabIndex == 1
                    ? BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      )
                    : null,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _setTab('steps');
                    });
                  },
                  child: Text(
                    'Steps',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: _selectedTabIndex == 1
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
          activeTab,
        ],
      ),
    );
  }
}
