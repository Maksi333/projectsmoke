class MainController {
  List<String> quotes = List.empty();
  double sparedBoxes = 0;
  double savings = 0;
  double boxPrice = 0;
  int pouchesPerDay = 0;
  int pouchesInBox = 0;

  DateTime startDate = DateTime.now();

  /// Calculate boxes spared since start date
  double calculateSparedBoxes() {
    if (pouchesPerDay <= 0 || pouchesInBox <= 0) return 0;
    if (startDate.isAfter(DateTime.now())) return 0;

    final diff = DateTime.now().difference(startDate);
    sparedBoxes = diff.inDays * (pouchesPerDay / pouchesInBox);

    // Round to 2 decimal places
    sparedBoxes = double.parse(sparedBoxes.toStringAsFixed(2));
    return sparedBoxes;
  }

  /// Calculate money saved since start date
  double calculateSavings() {
    // Ensure sparedBoxes is up-to-date
    calculateSparedBoxes();
    savings = sparedBoxes * boxPrice;

    // Round to 2 decimal places
    savings = double.parse(savings.toStringAsFixed(2));
    return savings;
  }

  /// Get clean time as a Duration
  Duration timeSinceStart() {
    if (startDate.isAfter(DateTime.now())) return Duration.zero;
    return DateTime.now().difference(startDate);
  }

  /// Format clean time as "X days, Y hours, Z minutes"
  String formattedTimeClean() {
    final duration = timeSinceStart();
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;

    return '$days days, $hours hours, $minutes minutes';
  }
}
