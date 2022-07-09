import 'package:flutter/material.dart';
import 'package:mentorgem/ui/widgets/balanced_text.dart';

class OnboardingStep extends StatelessWidget {
  const OnboardingStep({
    super.key,
    required this.title,
    required this.description,
    required this.background,
    required this.artwork,
  });

  final String title;
  final String description;
  final Widget background;
  final Widget artwork;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Positioned.fill(child: background),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: artwork,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(36),
            child: Column(
              children: [
                BalancedText(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 64),
      ],
    );
  }
}
