import 'package:flutter/material.dart';

class ItemSteps extends StatefulWidget {
  const ItemSteps({
    super.key,
    required this.steps,
  });

  final List<String> steps;

  @override
  State<ItemSteps> createState() => _ItemStepsState();
}

class _ItemStepsState extends State<ItemSteps> {
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
          for (final step in widget.steps)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 30),
              child: Text(
                '- $step',
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
