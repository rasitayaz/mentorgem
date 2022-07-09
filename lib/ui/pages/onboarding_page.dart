import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentorgem/ui/pages/sign_up_page.dart';
import 'package:mentorgem/ui/widgets/onboarding/actions.dart';
import 'package:mentorgem/ui/widgets/onboarding/indicator.dart';
import 'package:mentorgem/ui/widgets/onboarding/step.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  int _currentStep = 0;
  bool get _isLastStep => _currentStep == 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.addListener(() {
        if (_pageController.page! >= _currentStep + 0.5) {
          setState(() => _currentStep++);
        } else if (_pageController.page! <= _currentStep - 0.5) {
          setState(() => _currentStep--);
        }
      });
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
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: OnboardingIndicator(
                      currentStep: _currentStep,
                    ),
                  ),
                  Positioned.fill(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return OnboardingStep(
                              title: 'Join MentorGem with one click.',
                              description:
                                  'Joining MentorGem is easy. Join with Linkedin for the most optimal experience. Other login options are available.',
                              background: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, top: 16),
                                child: SvgPicture.asset(
                                  'assets/images/background-1.svg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              artwork:
                                  Image.asset('assets/images/onboarding-1.png'),
                            );
                          case 1:
                            return OnboardingStep(
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
                                width:
                                    MediaQuery.of(context).size.width * 3 / 4,
                              ),
                            );
                          case 2:
                            return OnboardingStep(
                              title: 'Connect together and talk.',
                              description:
                                  'Choose the mentor that you like and start interacting immediately. Enjoy the journey!',
                              background: Padding(
                                padding:
                                    const EdgeInsets.only(right: 72, top: 16),
                                child: SvgPicture.asset(
                                  'assets/images/background-3.svg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              artwork: Image.asset(
                                'assets/images/onboarding-3.png',
                                width:
                                    MediaQuery.of(context).size.width * 4 / 5,
                              ),
                            );
                          default:
                            return Container();
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: OnboardingActions(
                      isLastStep: _isLastStep,
                      onNext: () {
                        if (_pageController.page! <= 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.ease,
                          );
                        }
                      },
                      onSkip: () {
                        if (_pageController.page! <= 1) {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.ease,
                          );
                        }
                      },
                      onDone: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
