class Skill {
  const Skill({
    required this.title,
    required this.level,
  });

  final String title;
  final int level;

  String get levelTitle => getLevelTitle(level);

  static String getLevelTitle(int level) {
    switch (level) {
      case 1:
        return 'Novice';
      case 2:
        return 'Advanced';
      case 3:
        return 'Competent';
      case 4:
        return 'Proficient';
      case 5:
        return 'Expert';
      default:
        return 'Unknown';
    }
  }

  @override
  String toString() {
    return '$title - $levelTitle';
  }
}
