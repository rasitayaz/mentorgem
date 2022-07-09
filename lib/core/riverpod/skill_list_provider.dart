import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentorgem/core/models/skill_model.dart';

final skillListProvider =
    StateNotifierProvider<SkillList, List<Skill>>((ref) => SkillList());

class SkillList extends StateNotifier<List<Skill>> {
  SkillList() : super([]);

  void add(Skill skill) {
    state = [...state, skill];
  }

  void remove(Skill skill) {
    state = state.where((item) => item != skill).toList();
  }
}
