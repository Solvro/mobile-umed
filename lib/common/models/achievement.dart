import "stat.dart";

class Achievement extends Stat {
  final String description;

  Achievement({
    required super.id,
    required super.value,
    required this.description,
    required super.iconData,
    required super.iconColor,
  });
}
