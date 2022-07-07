import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorgem/models/skill.dart';
import 'package:mentorgem/views/balanced_text.dart';

class AddSkillDialog extends StatefulWidget {
  const AddSkillDialog({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  final Function(Skill skill) onAdd;

  @override
  State<AddSkillDialog> createState() => _AddSkillDialogState();
}

class _AddSkillDialogState extends State<AddSkillDialog> {
  final _inputController = TextEditingController();
  bool _hasError = false;
  String? _message;
  int _level = 0;

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
                  'Add a Skill',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Input a skill',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  hintText: 'Ex: Swift',
                ),
                onChanged: (value) {
                  setState(() => _message = null);
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Skill level',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 4),
              _buildLevelSelection(),
              const SizedBox(height: 12),
              if (_level > 0)
                Center(
                    child: Text(
                  Skill.getLevelTitle(_level),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )),
              if (_level > 0 && _message != null) const SizedBox(height: 8),
              if (_message != null) _buildMessage(),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (_inputController.text.isEmpty) {
                    setState(() {
                      _hasError = true;
                      _message = 'Please enter a skill';
                    });
                  } else if (_level == 0) {
                    setState(() {
                      _hasError = true;
                      _message = 'Please select a level';
                    });
                  } else {
                    widget.onAdd(Skill(
                      title: _inputController.text,
                      level: _level,
                    ));
                    _inputController.clear();
                    setState(() {
                      _hasError = false;
                      _level = 0;
                      _message =
                          'Skill has been added, you can add another one.';
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

  Widget _buildLevelSelection() {
    return Row(
      children: [
        Text(Skill.getLevelTitle(1), style: GoogleFonts.poppins(fontSize: 12)),
        const SizedBox(width: 8),
        for (int i = 1; i <= 5; i++) _buildLevelButton(i),
        const SizedBox(width: 8),
        Text(Skill.getLevelTitle(5), style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }

  Widget _buildLevelButton(int level) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _level = level;
          _message = null;
        }),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            decoration: BoxDecoration(
              color: _level >= level
                  ? Theme.of(context).colorScheme.primary
                  : const Color(0xFFC3C3C3),
              borderRadius: BorderRadius.horizontal(
                left: level == 1 ? const Radius.circular(8) : Radius.zero,
                right: level == 5 ? const Radius.circular(8) : Radius.zero,
              ),
            ),
            height: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildMessage() {
    Color color =
        _hasError ? Colors.red : Theme.of(context).colorScheme.primary;
    return Row(
      children: [
        FaIcon(
          _hasError
              ? FontAwesomeIcons.circleExclamation
              : FontAwesomeIcons.solidCircleCheck,
          color: color,
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: BalancedText(
            _message,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
