import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.currentStep,
  });

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 3),
        SizedBox(
          height: 16,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: index == currentStep ? 32 : 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: index == currentStep
                      ? Theme.of(context).colorScheme.primary
                      : const Color(0xFFC3C3C3),
                ),
              );
            }),
          ),
        ),
        const Spacer(flex: 2),
        const SizedBox(height: 64),
      ],
    );
  }
}
