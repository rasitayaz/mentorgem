import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingActions extends StatelessWidget {
  const OnboardingActions({
    super.key,
    required this.isLastStep,
    required this.onSkip,
    required this.onNext,
    required this.onDone,
  });

  final bool isLastStep;
  final Function() onNext;
  final Function() onSkip;
  final Function() onDone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: AnimatedSwitcher(
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        duration: const Duration(milliseconds: 200),
        child: isLastStep
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: onDone,
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF007AFF),
                    ),
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: FaIcon(FontAwesomeIcons.linkedin),
                    ),
                    label: const Text('Get started with LinkedIn'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: onDone,
                    child: const Text('Continue as a guest'),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: onSkip,
                      child: const Text('Skip'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onNext,
                      child: const Text('Next'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
