import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipList<T> extends ConsumerWidget {
  const ChipList({
    super.key,
    required this.title,
    required this.type,
    required this.subtitle,
    required this.items,
    required this.onClickAdd,
    required this.onDelete,
  });

  final String title;
  final String type;
  final String subtitle;
  final List<T> items;
  final Function() onClickAdd;
  final Function(T item) onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onDeleted: () => onDelete(item),
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
}
