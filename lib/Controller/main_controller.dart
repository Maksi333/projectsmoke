class MainController {
  List<String> quotes = List.empty();
  double sparedBoxes = 0;
  double savings = 0;
  double boxPrice = 0;
  int pouchesPerDay = 0;
  int pouchesInBox = 0;

  DateTime startDate = DateTime.now();
  int daysClean = 0;

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

  /// Calculate number of days clean since start date
  int daysSinceStart() {
    if (startDate.isAfter(DateTime.now())) return 0;

    final diff = DateTime.now().difference(startDate);
    daysClean = diff.inDays;
    return daysClean;
  }
}
