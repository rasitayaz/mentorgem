import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorgem/core/models/language_model.dart';
import 'package:mentorgem/core/riverpod/language_list_provider.dart';
import 'package:mentorgem/ui/widgets/balanced_text.dart';

class AddLanguageDialog extends ConsumerStatefulWidget {
  const AddLanguageDialog({super.key});

  @override
  ConsumerState<AddLanguageDialog> createState() => _AddLanguageDialogState();
}

class _AddLanguageDialogState extends ConsumerState<AddLanguageDialog> {
  final _inputController = TextEditingController();
  bool _hasError = false;
  String? _message;

  Color get _messageColor =>
      _hasError ? Colors.red : Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Add a Language',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Input a language',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  hintText: 'Ex: Turkish',
                ),
                autofillHints: const [AutofillHints.language],
                onChanged: (value) {
                  setState(() => _message = null);
                },
              ),
              const SizedBox(height: 12),
              if (_message != null)
                Row(
                  children: [
                    FaIcon(
                      _hasError
                          ? FontAwesomeIcons.circleExclamation
                          : FontAwesomeIcons.solidCircleCheck,
                      color: _messageColor,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: BalancedText(
                        _message,
                        style: GoogleFonts.poppins(
                          color: _messageColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (_inputController.text.isEmpty) {
                    setState(() {
                      _hasError = true;
                      _message = 'Please enter a language';
                    });
                  } else {
                    ref
                        .read(languageListProvider.notifier)
                        .add(Language(_inputController.text));
                    _inputController.clear();
                    setState(() {
                      _hasError = false;
                      _message =
                          'Language has been added, you can add another one.';
                    });
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
