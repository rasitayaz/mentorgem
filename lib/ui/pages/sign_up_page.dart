import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorgem/core/models/language_model.dart';
import 'package:mentorgem/core/models/skill_model.dart';
import 'package:mentorgem/core/riverpod/language_list_provider.dart';
import 'package:mentorgem/core/riverpod/skill_list_provider.dart';
import 'package:mentorgem/ui/pages/onboarding_page.dart';
import 'package:mentorgem/ui/widgets/add_language_dialog.dart';
import 'package:mentorgem/ui/widgets/add_skill_dialog.dart';
import 'package:mentorgem/ui/widgets/chip_list.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              Text('Profile',
                                  style: Theme.of(context).textTheme.headline1),
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
                      const SizedBox(height: 16),
                      Text(
                        'Your LinkedIn URL',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _inputController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your LinkedIn profile URL',
                        ),
                        autofillHints: const [AutofillHints.url],
                        keyboardType: TextInputType.url,
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          String linkedInUrl = _inputController.text;
                          if (linkedInUrl.isEmpty) return;
                          String url = linkedInUrl.contains('https://')
                              ? linkedInUrl
                              : 'https://$linkedInUrl';
                          launchUrlString(url,
                              mode: LaunchMode.externalApplication);
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
                      Consumer(builder: (context, ref, _) {
                        return ChipList<Skill>(
                          title: 'Skills',
                          type: 'Skill',
                          subtitle: '(Ex: Java, business strategy)',
                          items: ref.watch(skillListProvider),
                          onDelete: (item) {
                            ref.read(skillListProvider.notifier).remove(item);
                          },
                          onClickAdd: () {
                            showDialog(
                              context: context,
                              builder: (context) => const AddSkillDialog(),
                            );
                          },
                        );
                      }),
                      const SizedBox(height: 16),
                      Consumer(builder: (context, ref, _) {
                        return ChipList<Language>(
                          title: 'Languages',
                          type: 'Language',
                          subtitle: '(Optional)',
                          items: ref.watch(languageListProvider),
                          onDelete: (item) {
                            ref
                                .read(languageListProvider.notifier)
                                .remove(item);
                          },
                          onClickAdd: () {
                            showDialog(
                              context: context,
                              builder: (context) => const AddLanguageDialog(),
                            );
                          },
                        );
                      }),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const OnboardingPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text('Get Started'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
