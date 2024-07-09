import 'package:flutter/material.dart';

class ItemIngredients extends StatelessWidget {
  const ItemIngredients({
    super.key,
    required this.ingredients,
  });

  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 14),
        for (final ingredient in ingredients)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(
              ingredient,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
      ],
    );
  }
}
