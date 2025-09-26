import 'dart:math';

class MainController {
  List<String> quotes = List.empty();
  double sparedBoxes = -1;
  double savings = -1;

  DateTime startDate = DateTime(2023, 1, 1);
  int daysClean = -1;

  double calculateSparedBoxes() {
    // Example calculation
    sparedBoxes = Random().nextDouble() * 100;
    return sparedBoxes;
  }

  double calculateSavings() {
    // Example calculation
    savings = Random().nextDouble() * 1000;
    return savings;
  }

  int daysSinceStart() {
    // Example calculation
    daysClean = Random().nextInt(365);
    return daysClean;
  }
}
