import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorgem/pages/onboarding_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _linkedInUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                Text(
                  'Your LinkedIn URL',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 4),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your LinkedIn profile',
                  ),
                  autofillHints: const [AutofillHints.url],
                  keyboardType: TextInputType.url,
                  onChanged: (value) => _linkedInUrl = value,
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    String url = _linkedInUrl.contains('https://')
                        ? _linkedInUrl
                        : 'https://$_linkedInUrl';
                    launchUrlString(url, mode: LaunchMode.externalApplication);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circleExclamation,
                        color: Theme.of(context).colorScheme.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Click here for your LinkedIn profile',
                        style: GoogleFonts.poppins(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildChipList(
                  title: 'Skills',
                  subtitle: '(Ex: Java, business strategy)',
                  items: [],
                ),
                const SizedBox(height: 16),
                _buildChipList(
                  title: 'Languages',
                  subtitle: '(Optional)',
                  items: [],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _navigateToOnboarding,
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  'Build your',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF5C5C5C),
                  ),
                ),
                Text('Profile', style: Theme.of(context).textTheme.headline1),
              ],
            ),
            const Spacer(),
            Image.asset(
              'assets/images/cube.png',
              height: 48,
            ),
          ],
        ),
        const Text('Enter your skills to improve match results.'),
      ],
    );
  }

  Widget _buildChipList<T>({
    required String title,
    String? subtitle,
    required List<T> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Skills',
                style: Theme.of(context).textTheme.headline3,
              ),
              if (subtitle != null)
                TextSpan(
                  text: ' $subtitle',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            return Chip(
              label: Text(item.toString()),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _navigateToOnboarding() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const OnboardingPage()),
      (route) => false,
    );
  }
}
