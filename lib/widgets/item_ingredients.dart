import 'package:flutter/material.dart';

class ItemIngredients extends StatefulWidget {
  const ItemIngredients({
    super.key,
    required this.ingredients,
  });

  final List<String> ingredients;

  @override
  State<ItemIngredients> createState() => _ItemIngredientsState();
}

class _ItemIngredientsState extends State<ItemIngredients> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: opacity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          for (final ingredient in widget.ingredients)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 30),
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
      ),
    );
  }
}
