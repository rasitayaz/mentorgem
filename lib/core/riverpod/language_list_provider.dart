import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentorgem/core/models/language_model.dart';

final languageListProvider =
    StateNotifierProvider<LanguageList, List<Language>>(
        (ref) => LanguageList());

class LanguageList extends StateNotifier<List<Language>> {
  LanguageList() : super([]);

  void add(Language language) {
    state = [...state, language];
  }

  void remove(Language language) {
    state = state.where((item) => item != language).toList();
  }
}
