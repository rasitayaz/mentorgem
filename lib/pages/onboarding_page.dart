import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentorgem/views/balanced_text.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const Duration _animDuration = Duration(milliseconds: 350);
  static const Duration _fastAnimDuration = Duration(milliseconds: 200);
  static const double _indicatorHeight = 16;

  final _pageController = PageController();
  int _currentStep = 0;
  bool get _isLastStep => _currentStep == 2;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page! >= _currentStep + 0.5) {
        setState(() => _currentStep++);
      } else if (_pageController.page! <= _currentStep - 0.5) {
        setState(() => _currentStep--);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: _buildStepIndicator()),
            Positioned.fill(
              child: PageView(
                controller: _pageController,
                children: [
                  _buildOnboardingStep(
                    title: 'Join MentorGem with one click.',
                    description:
                        'Joining MentorGem is easy. Join with Linkedin for the most optimal experience. Other login options are available.',
                    background: Padding(
                      padding: const EdgeInsets.only(left: 32, top: 16),
                      child: SvgPicture.asset(
                        'assets/images/background-1.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    artwork: Image.asset('assets/images/onboarding-1.png'),
                  ),
                  _buildOnboardingStep(
                    title: 'Find your mentor quickly.',
                    description:
                        'Our smart match technology will match you with a mentor best fit to help you achieve your goals.',
                    background: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SvgPicture.asset(
                        'assets/images/background-2.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    artwork: Image.asset(
                      'assets/images/onboarding-2.png',
                      width: MediaQuery.of(context).size.width * 3 / 4,
                    ),
                  ),
                  _buildOnboardingStep(
                    title: 'Connect together and talk.',
                    description:
                        'Choose the mentor that you like and start interacting immediately. Enjoy the journey!',
                    background: Padding(
                      padding: const EdgeInsets.only(right: 72, top: 16),
                      child: SvgPicture.asset(
                        'assets/images/background-3.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    artwork: Image.asset(
                      'assets/images/onboarding-3.png',
                      width: MediaQuery.of(context).size.width * 4 / 5,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildActions(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Column(
      children: [
        const Spacer(flex: 3),
        SizedBox(
          height: _indicatorHeight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (index) {
              return AnimatedContainer(
                duration: _fastAnimDuration,
                curve: Curves.ease,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: index == _currentStep ? 32 : 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: index == _currentStep
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

  Widget _buildOnboardingStep({
    required String title,
    required String description,
    required Widget background,
    required Widget artwork,
  }) {
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
        const SizedBox(height: _indicatorHeight),
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

  Widget _buildActions() {
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
        duration: _fastAnimDuration,
        child: _isLastStep
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF007AFF),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        FaIcon(FontAwesomeIcons.linkedin),
                        SizedBox(width: 12),
                        Text('Get started with LinkedIn'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Continue as a guest'),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (_pageController.page! <= 1) {
                          _pageController.animateToPage(
                            2,
                            duration: _animDuration,
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: const Text('Skip'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_pageController.page! <= 1) {
                          _pageController.nextPage(
                            duration: _animDuration,
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: const Text('Next'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
