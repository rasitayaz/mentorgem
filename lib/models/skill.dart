class Skill {
  const Skill({
    required this.title,
    required this.level,
  });

  final String title;
  final int level;

  String get levelTitle {
    switch (level) {
      case 1:
        return 'Beginner';
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
