import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: InkWell(
        onTap: () => onSelectMeal(meal),
        child: Hero(
          tag: meal.id,
          placeholderBuilder: (context, heroSize, child) =>
              Opacity(opacity: 0.2, child: child),
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            return MealItemImage(meal: meal);
          },
          child: MealItemImage(meal: meal),
        ),
      ),
    );
  }
}
