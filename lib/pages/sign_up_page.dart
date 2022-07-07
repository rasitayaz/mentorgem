import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorgem/models/language.dart';
import 'package:mentorgem/models/skill.dart';
import 'package:mentorgem/pages/onboarding_page.dart';
import 'package:mentorgem/views/add_language_dialog.dart';
import 'package:mentorgem/views/add_skill_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final List<Language> _languages = [];
  final List<Skill> _skills = [];
  String _linkedInUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SafeArea(
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
                    hintText: 'Enter your LinkedIn profile URL',
                  ),
                  autofillHints: const [AutofillHints.url],
                  keyboardType: TextInputType.url,
                  onChanged: (value) => _linkedInUrl = value,
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    if (_linkedInUrl.isEmpty) return;
                    String url = _linkedInUrl.contains('https://')
                        ? _linkedInUrl
                        : 'https://$_linkedInUrl';
                    launchUrlString(url, mode: LaunchMode.externalApplication);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circleExclamation,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
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
                  type: 'Skill',
                  subtitle: '(Ex: Java, business strategy)',
                  items: _skills,
                  onClickAdd: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddSkillDialog(
                        onAdd: (skill) {
                          setState(() => _skills.add(skill));
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildChipList(
                  title: 'Languages',
                  type: 'Language',
                  subtitle: '(Optional)',
                  items: _languages,
                  onClickAdd: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddLanguageDialog(
                        onAdd: (language) {
                          setState(() => _languages.add(language));
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
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
    required String type,
    String? subtitle,
    required List<T> items,
    required void Function() onClickAdd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
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
          children: items.map<Widget>((item) {
            return InputChip(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              label: Text(
                item.toString(),
                style: GoogleFonts.poppins(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              deleteIcon: FaIcon(
                FontAwesomeIcons.solidCircleXmark,
                color: Theme.of(context).scaffoldBackgroundColor,
                size: 20,
              ),
              onDeleted: () {
                setState(() => items.remove(item));
              },
            );
          }).toList()
            ..add(
              ActionChip(
                elevation: 2,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                avatar: FaIcon(
                  FontAwesomeIcons.circlePlus,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                label: Text(
                  items.isEmpty ? 'First $type' : type,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                onPressed: onClickAdd,
              ),
            ),
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
