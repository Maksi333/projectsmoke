import 'package:flutter/material.dart';

var moneySaved = 0.0;

class MoneySavedPage extends StatelessWidget {
  const MoneySavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Text(
                'You are doing great!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    'Money Saved',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    '$moneySaved Dkk',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateSavings(double amount) {
    moneySaved += amount;
    //todo
  }
}
