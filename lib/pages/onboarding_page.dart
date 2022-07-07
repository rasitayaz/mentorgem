import 'package:flutter/material.dart';
import 'package:mentorgem/views/balanced_text.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                children: [
                  _buildOnboardingStep(
                    title: 'Join MentorGem with one click.',
                    description:
                        'Joining MentorGem is easy. Join with Linkedin for the most optimal experience. Other login options are available.',
                  ),
                  _buildOnboardingStep(
                    title: 'Find your mentor quickly.',
                    description:
                        'Our smart match technology will match you with a mentor best fit to help you achieve your goals.',
                  ),
                  _buildOnboardingStep(
                    title: 'Connect together and talk.',
                    description:
                        'Choose the mentor that you like and start interacting immediately. Enjoy the journey!',
                  ),
                ],
              ),
            ),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingStep({
    required String title,
    required String description,
  }) {
    return Padding(
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
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text('Skip'),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
